Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262983AbVD2VFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVD2VFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVD2VDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:03:41 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:43469 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S262980AbVD2VAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:00:55 -0400
Message-ID: <4272A07C.7000605@austin.rr.com>
Date: Fri, 29 Apr 2005 16:00:44 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: which ioctls matter across filesystems
References: <42728964.8000501@austin.rr.com> <1114804426.12692.49.camel@lade.trondhjem.org> <1114805033.6682.150.camel@betsy> <42729D51.5050203@austin.rr.com> <1114807835.6682.156.camel@betsy>
In-Reply-To: <1114807835.6682.156.camel@betsy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>So a client adds a watch and the server needs to then physically add the
>inotify watch?
>
>  
>
Yes, this creates the interesting situation of two responses (one from 
the local client code, and one from the server) potentially coming as a 
client changes a file which he has a watch on.

>If you have a user-space, user-space could just add an inotify watch.
>
>But I guess you live entirely in kernel-space?  Couldn't we just export
>our "add watch" interface to you?
>
>	Robert Love
>
>  
>
Yes - add watch could be exported, I don't see a way around this since a 
filesystem has to be able to tell the server what to watch.  It does not 
really matter if that were done in kernel or not, but I would prefer it 
to be done in kernel since that would avoid having to ioctl down to the 
kernel
