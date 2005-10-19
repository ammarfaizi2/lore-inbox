Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVJSDf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVJSDf0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 23:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVJSDf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 23:35:26 -0400
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:32967 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932434AbVJSDfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 23:35:25 -0400
Message-ID: <4355BEF4.8000800@cfl.rr.com>
Date: Tue, 18 Oct 2005 23:35:16 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Bailey <jbailey@ubuntu.com>
CC: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org,
       ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: Re: Keep initrd tasks running?
References: <4355494C.5090707@comcast.net> <1129663759.18784.98.camel@localhost.localdomain>
In-Reply-To: <1129663759.18784.98.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am confused.  I thought that once the initramfs init execs the real 
init, the initramfs is freed.  It can't be freed if there are processes 
that still have open files there, so that would seem to prevent any 
processes being started in the initramfs and continuing after the real 
system is booted. 


Jeff Bailey wrote:

>This is much more easily supported in Breezy.  usplash is started at the
>top of the initramfs (from the init-top hook) and lives until we start
>gdm.
>
>The biggest constraint is that you don't have write access to the target
>root filesystem (since it's mounted readonly).  However, /dev is a tmpfs
>that is move mounted to the new root system.  If you need to have
>sockets open or store data, you can use that.  usplash does this for its
>socket.
>
>Note that the initramfs startup sequence isn't at all similar to the old
>initrd startups.  It should be easy for you to cleanly add what you want
>under /etc/mkinitramfs/scripts and not have to modify the
>initramfs-tools package.  /usr/share/doc/initramfs-tools/HACKING
>contains some starter information.
>
>Hope this helps!
>
>Tks,
>Jeff Bailey
>
>
>
>
>
>  
>

