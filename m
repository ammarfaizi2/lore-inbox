Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUAXXVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUAXXVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:21:44 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:4802 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263173AbUAXXVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:21:41 -0500
Subject: Re: Problem with module-init-tools
From: Christophe Saout <christophe@saout.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040124222907.GA4072@werewolf.able.es>
References: <20040124222907.GA4072@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1074986496.10332.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jan 2004 00:21:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa, den 24.01.2004 schrieb J.A. Magallon um 23:29:

> I have a problem with modprobe, 2.6.2-rc1-mm2, and agpgart.
> 
> With 2.4, I had this setup to have agpgart loaded:
> 
> alias char-major-226 agpgart
> 
> With 2.6 and the same setup, that module is loaded. But as agpgart backend is
> now split, I need to load also intel-agp.ko. I read manuals, and corrected my
> modprobe.conf this way:
> 
> install agpgart /sbin/modprobe intel-agp; /sbin/modprobe --ignore-install agpgart;
> 
> But it goes on an infinite loop :(.

Well, I suppose it's because modprobe intel-agp tries to load agpgart
and that's where it loops. I think you should try to modprobe
--ignore-install agpgart first so that it's already loaded when you
insert intel-agp. And probably use a && between the two commands.


