Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbTDFQZ4 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 12:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbTDFQZ4 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 12:25:56 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:55433 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263032AbTDFQZz (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 12:25:55 -0400
Date: Sun, 6 Apr 2003 18:37:16 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poweroff problem
Message-ID: <20030406163716.GB8303@vana.vc.cvut.cz>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com> <20030406233319.042878d3.sfr@canb.auug.org.au> <20030406155814.68c5c908.us15@os.inf.tu-dresden.de> <20030407002703.16993dc4.sfr@canb.auug.org.au> <20030406174655.592b7f60.us15@os.inf.tu-dresden.de> <1049639095.963.0.camel@dhcp22.swansea.linux.org.uk> <20030406183713.3435d742.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030406183713.3435d742.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 06:37:13PM +0200, Udo A. Steinberg wrote:
> On 06 Apr 2003 15:24:55 +0100 Alan Cox (AC) wrote:
> 
> AC> We rely on the bios for the power off sequences. Many BIOS vendors do
> AC> set it up to share the bios code it seems
> 
> Ok, but this does not explain why things work with 2.5.66 on the exact same
> machine, unless 2.5 had workarounds for BIOS bugs or didn't use the BIOS for
> power off. Board is an Asus A7V, BIOS version 1011.

On A7V with BIOS 1012a01 2.5.40+ ACPI always worked flawlessly, while 2.4.x has
problems. Currently (2.4.21-pre7) is better than before: it writes some panic
to screen, but poweroffs immediately after that (and sorry, nearest serial 
console is about 5km far away, and everybody should use 2.5.x anyway), so I
always suspected that problem is not in poweroff itself, but in some
driver's devexit procedure (I have enabled hotplug in kernel, so __devexit
is not stripped out).

And if you are talking about A7V, for some old ACPI (maybe all 2.4.x, I have
no idea) take a look at http://groups.google.com/groups?q=vandrovec+acpi+poweroff&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=linux.kernel.20020124184011.GA23785%40vana.vc.cvut.cz&rnum=1
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

