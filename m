Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTDFQBm (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 12:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTDFQBm (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 12:01:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49806
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262622AbTDFQBl (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 12:01:41 -0400
Subject: Re: poweroff problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030406183713.3435d742.us15@os.inf.tu-dresden.de>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
	 <20030406233319.042878d3.sfr@canb.auug.org.au>
	 <20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
	 <20030407002703.16993dc4.sfr@canb.auug.org.au>
	 <20030406174655.592b7f60.us15@os.inf.tu-dresden.de>
	 <1049639095.963.0.camel@dhcp22.swansea.linux.org.uk>
	 <20030406183713.3435d742.us15@os.inf.tu-dresden.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049642082.1218.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 16:14:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 17:37, Udo A. Steinberg wrote:
> On 06 Apr 2003 15:24:55 +0100 Alan Cox (AC) wrote:
> 
> AC> We rely on the bios for the power off sequences. Many BIOS vendors do
> AC> set it up to share the bios code it seems
> 
> Ok, but this does not explain why things work with 2.5.66 on the exact same
> machine, unless 2.5 had workarounds for BIOS bugs or didn't use the BIOS for
> power off. Board is an Asus A7V, BIOS version 1011.

Different options for reboot (16 v 32) perhaps, might even be something is
random as which way the carry flag is when the bios code is called. If you
want to be sure for the APM case stick a printk just before we drop into
the BIOS and make sure we oops after and not before..

