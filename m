Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVKLWWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVKLWWy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVKLWWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:22:54 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:42258 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S964849AbVKLWWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:22:53 -0500
Date: Sat, 12 Nov 2005 23:24:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Henrik Christian Grove <grove@fsr.ku.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gen_initramfs_list.sh: Cannot open 'y'
Message-ID: <20051112222425.GC10228@mars.ravnborg.org>
References: <7gk6fdy5t9.fsf@serena.fsr.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7gk6fdy5t9.fsf@serena.fsr.ku.dk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 09:22:42PM +0100, Henrik Christian Grove wrote:
> 
> When I try to compile a 2.6.14 kernel on my new laptop, I get the
> following error:
> x40:~/kerne/linux-2.6.14# make
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
> dnsdomainname: Host name lookup failure
>   CHK     usr/initramfs_list
>   /root/kerne/linux-2.6.14/scripts/gen_initramfs_list.sh: Cannot open 'y'
> make[1]: *** [usr/initramfs_list] Error 1
> make: *** [usr] Error 2
> 
> I simply don't understand what it's trying to do, and google doesn't
> seem to know that error. Can anyone here help?

Root cause is dnsdomainname that fails.
Try to do:
echo domain.com > /etc/dnsdomainname

or similar - depending on distribution.
That should fix the dnsdomainname issue.

	Sam
