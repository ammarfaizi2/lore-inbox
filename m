Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVGTNwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVGTNwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVGTNwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:52:14 -0400
Received: from main.gmane.org ([80.91.229.2]:27295 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261226AbVGTNwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:52:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [patch] I-pipe 2.6.12-v0.9-02
Date: Wed, 20 Jul 2005 13:37:00 +0000 (UTC)
Message-ID: <loom.20050720T152317-881@post.gmane.org>
References: <42DBB18E.7090707@xenomai.org> <200507181244.40583.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.224.74.121 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050306 Firefox/1.0.1 (Debian package 1.0.1-2))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett <at> verizon.net> writes:

> 
> On Monday 18 July 2005 09:41, Philippe Gerum wrote:
> >The interrupt pipeline patch v0.9-02 has been released, fixing a
> > latency spot and a bug in the deferred printk() mechanism.
> >
> >A split version of the patch for x86, ppc32 and ia64 is available
> > here: http://download.gna.org/adeos/patches/v2.6/ipipe/split/
> >
> >Patch sequence to build a Linux 2.6.12 tree with I-pipe support:
> >
> >http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
> >http://download.gna.org/adeos/patches/v2.6/ipipe/ipipe-2.6.12-v0.9-0
> >2.patch
> 
> Will this then work with emc?  emc, when run, loads the adeos stuff, 
> then unloads it when its stopped.  emc being the linux cnc machine 
> controller.
> 
> If it will, I'd like to play with it on a bdi-4.20 install.
> 
> Or is this a seperate patch?
> 

This will be a separate patch against the I-pipe, adding the missing bits to
support what emc and the like need, in order to run the real-time extension they
rely on. The I-pipe patch series consists of largely reworked Adeos patches only
retaining the interrupt pipeline code from its ancestor. We need a few other
things to support what those real-time extension need to fully cooperate with
Linux (which goes beyond just interposing on interrupts actually).

--
Philippe.

