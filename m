Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbTAaPtp>; Fri, 31 Jan 2003 10:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTAaPtp>; Fri, 31 Jan 2003 10:49:45 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:35228 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261518AbTAaPto>; Fri, 31 Jan 2003 10:49:44 -0500
Date: Fri, 31 Jan 2003 16:42:51 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Module alias and device table support.
Message-ID: <20030131164251.C641@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0301302351550.15587-100000@chaos.physics.uiowa.edu> <200301310941.h0V9fa89002888@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200301310941.h0V9fa89002888@eeyore.valparaiso.cl>; from brand@jupiter.cs.uni-dortmund.de on Fri, Jan 31, 2003 at 10:41:36AM +0100
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18edZM-0004EI-00*DZ9i0Lejw2.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 10:41:36AM +0100, Horst von Brand wrote:
> I fail to see why a module would have to declare aliases for itself.
> Aliases are an userspace/after boot problem (i.e., which one is eth0?,
> etc) Please read the FAQ at  http://www.tux.org/lkml/

I second this. A module can declare, what it provides (e.g. ethX,
scsi-host-adapter), but what is loaded for each actual device
should be decided be be user space (/sbin/hotplug?).

Identification, enumeration and classification is fine in the
kernel, but assigning actual devices to each driver 
(e.g. host-adapter-A to a request_module("scsi-host-adapter"))
should be done by user space, where important.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
