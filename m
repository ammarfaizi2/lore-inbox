Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVDXWGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVDXWGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 18:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVDXWGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 18:06:34 -0400
Received: from router.student.pw.edu.pl ([194.29.137.75]:42658 "EHLO
	router.student.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262458AbVDXWGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 18:06:31 -0400
Message-ID: <426C185C.1050204@genesilico.pl>
Date: Mon, 25 Apr 2005 00:06:20 +0200
From: maciek <maciek@genesilico.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <20050424214339.GD9304@mail.shareable.org>
In-Reply-To: <20050424214339.GD9304@mail.shareable.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jamie Lokier napisał(a):

>Al Viro wrote:
>  
>
>>On Sun, Apr 24, 2005 at 11:15:35PM +0200, Miklos Szeredi wrote:
>>    
>>
>>>No.  You can't set "mount environment" in scp.
>>>      
>>>
>>Of course you can.  It does execute the obvious set of rc files.
>>    
>>
>
>It doesn't work for the specified use-scenario.  The reason is that
>there is no command or system call that can be executed from those rc
>files to join an existing namespace.
>
>He wants to do this:
>
>   1. From client, login to server and do a usermount on $HOME/private.
>
>   2. From client, login to server and read the files previously mounted.
>
>-- Jamie
>  
>
Maybe, pam_mount would be the solution?

http://www.flyn.org/projects/pam_mount/

it provides mounting a filesystem when logging in, and unmounting on
exit, just set the mount options.

Maciek Stopa


