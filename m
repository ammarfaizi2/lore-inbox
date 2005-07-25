Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVGYLK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVGYLK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 07:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVGYLK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 07:10:26 -0400
Received: from animx.eu.org ([216.98.75.249]:31444 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261224AbVGYLKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 07:10:24 -0400
Date: Mon, 25 Jul 2005 07:26:22 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stripping in module
Message-ID: <20050725112622.GA1537@animx.eu.org>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <809C13DD6142E74ABE20C65B11A24398020882@www.telos.de> <Pine.LNX.4.61.0507250928300.18209@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507250928300.18209@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> >What is the best way to do this with v2.6.
> >
> >I have tried e.g. to remove all symbols starting with "telos"
> >from the module like this (after kbuild):
> >
> >  strip -w -K '!telos*' -K 'telosi2c_usb_driver' telosi2c_linux.ko
> 
> Yes, I'd also be interested in what sections can actually be stripped, if any.
> Userspace shared libs for example can be `strip -s`'ed and they still work as 
> expected, does not look like this holds for kernel modules.

I would also be interested in this.  For instance the AIC7xxx driver has
every PCI id in the module I think in the .modinfo section which is not
truely required once depmod has been run.  I wanted to strip out this
information so that modules would be smaller.  I had stripped this section
out in testing a floppy boot and then most modules would not load anymore.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
