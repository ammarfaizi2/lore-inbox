Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317374AbSFHBF2>; Fri, 7 Jun 2002 21:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317375AbSFHBF2>; Fri, 7 Jun 2002 21:05:28 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:27659 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317374AbSFHBF1>;
	Fri, 7 Jun 2002 21:05:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dave Jones <davej@suse.de>
Date: Sat, 8 Jun 2002 03:04:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Updates to matroxfb: do you want DFP or TVOut on G450/G
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        diego@biurrun.de, jerry.c.t@web.de, mike@pieper-family.de,
        hollis@austin.ibm.com
X-mailer: Pegasus Mail v3.50
Message-ID: <77417CB2C9F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Jun 02 at 2:57, Dave Jones wrote:
> On Sat, Jun 08, 2002 at 02:45:39AM +0200, Petr Vandrovec wrote:
>  > (4) You can read PINS through /proc.
>  > (H) Change /proc code to use driverfs instead. Linus refused
>  >     /proc based code already.
> 
> One of the first things I ever wrote for Linux was a PINS decoder.
> It read from /dev/mem to get the PINS structure. Any reason
> why this isn't good enough, and we need the kernel exporting PINS ?

It does not print decoded structure, it shows it in raw format, 64-128
bytes, just to avoid userspace parsing /dev/mem because of matroxfb 
did it already (and matroxfb needs PINS to properly initialize Gx50 
cards in non-PC hardware). And it may be non-trivial to get PINS from
userspace at all because of BIOSes may be disabled by firmware 
(and f.e. on my PC they are disabled for secondary adapters, so 
simple parsing /dev/mem leads to nowhere because of BIOS is hidden).

Besides that, it lives in complete separate file, so it is easy
to add/remove it.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
