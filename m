Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUFANnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUFANnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUFANnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:43:41 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:65260 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S265038AbUFANni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:43:38 -0400
Message-ID: <40BC8824.4060809@serice.net>
Date: Tue, 01 Jun 2004 08:44:04 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iso9660 inodes beyond 4GB
References: <40BB714B.8050504@serice.net> <16572.868.477203.352122@cse.unsw.edu.au>
In-Reply-To: <16572.868.477203.352122@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The easiest way to trigger the error is:
 >   export the filesystem and mount it on some client.
 >   On the client, cd into some subdirectory.
 >   On the server, unexport, unmount, remount, reexport
 >     (i.e. simulate a reboot).
 >   On the client "ls -l"
 >
 > That should cause the server to try to call get_parent to find the
 > path back up to the root of the filesystem.

Thanks, that definitely triggers an error.


 > A quick glance at the rest of the export related code suggests that
 > it is all ok.

I'm not sure who I have to thank, but the code in fs/exportfs made it
much easier than expected.


Paul Serice

