Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWEUFTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWEUFTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 01:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEUFTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 01:19:25 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:19386 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751453AbWEUFTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 01:19:24 -0400
Date: Sun, 21 May 2006 01:19:20 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Valdis.Kletnieks@vt.edu
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm2
In-Reply-To: <200605210428.k4L4S0nv013532@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0605210119060.25962@d.namei>
References: <20060520054103.46a6edb5.akpm@osdl.org>
 <200605210428.k4L4S0nv013532@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2006, Valdis.Kletnieks@vt.edu wrote:

> On Sat, 20 May 2006 05:41:03 PDT, Andrew Morton said:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm2/
> 
> secmark-add-new-packet-controls-to-selinux.patch looks fishy:
> 
> --- devel/security/selinux/Kconfig~secmark-add-new-packet-controls-to-selinux   2006
> -05-18 03:04:58.000000000 -0700
> +++ devel-akpm/security/selinux/Kconfig 2006-05-18 03:04:58.000000000 -0700
> @@ -1,6 +1,6 @@
>  config SECURITY_SELINUX
>         bool "NSA SELinux Support"
> -       depends on SECURITY_NETWORK && AUDIT && NET && INET
> +       depends on SECURITY_NETWORK && AUDIT && NET && INET && NETWORK_SECMARK
>         default n
>         help
>           This selects NSA Security-Enhanced Linux (SELinux).
> 
> Was it *really* intended that SELINUX not be selectable if NETWORK_SECMARK
> isn't present?

Yes, it's required for SELinux.


- James
-- 
James Morris
<jmorris@namei.org>
