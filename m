Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUHSJ6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUHSJ6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHSJ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:58:39 -0400
Received: from stacja.kursor.pl ([80.55.191.138]:63921 "EHLO stacja.kursor.pl")
	by vger.kernel.org with ESMTP id S264881AbUHSJ50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:57:26 -0400
Date: Thu, 19 Aug 2004 11:57:12 +0200 (CEST)
From: Janusz Dziemidowicz <rraptorr@kursor.pl>
To: Diego Calleja <diegocg@teleline.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3 documentation (lack of)
In-Reply-To: <20040818184249.5b266538.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.61.0408191144170.14966@stacja.kursor.pl>
References: <20040818025951.63c4134e.diegocg@teleline.es>
 <200408172301.09350.ryan@spitfire.gotdns.org> <20040818133818.7b0582f3.diegocg@teleline.es>
 <Pine.LNX.4.61.0408181414450.18542@stacja.kursor.pl>
 <20040818184249.5b266538.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, Diego Calleja wrote:

> Thanks. I've recollected those, explained it a bit (except the barrier bits,
> I don't really mean what barriers are), and updated ext2 documentation with
> some of them, and deleted a small comentary about ext3 not being available.

> +user_xattr		(*)	Enables POSIX Extended Attributes. It's enabled by
> +				default, however you need to confifure its support
> +				(CONFIG_EXT2_FS_XATTR). This is neccesary if you want
> +				to use POSIX Acces Control Lists support. You can visit
> +				http://acl.bestbits.at to know more about POSIX Extended
> +				attributes.
> +
> +nouser_xattr			Disables POSIX Extended Attributes.
> +
> +acl			(*)	Enables POSIX Access Control Lists support. This is
> +				enabled by default, however you need to configure
> +				its support (CONFIG_EXT2_FS_POSIX_ACL). If you want
> +				to know more about ACLs visit http://acl.bestbits.at
> +
> +noacl				This option disables POSIX Access Control List support.

Hmmm, after a quick look on source code one more clarification. Since 
2.4.20 one can set default mount options in ext2/ext3 superblock using 
tune2fs. If user_xattr or acl is there, then they are enabled by default 
while mounting such filesystem. However default mount options field in 
superblock is by default empty, so user_xattr and acl are not enabled by 
default for most users. Please correct me if I'm wrong.

Another thing is that a quick grep for reservation and resize options 
shows nothing in latest kernel. Are you sure that these options exist? For 
sure reiserfs has resize option.

--
Janusz Dziemidowicz
rraptorr@kursor.pl
