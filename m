Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSGYMsl>; Thu, 25 Jul 2002 08:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSGYMsl>; Thu, 25 Jul 2002 08:48:41 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:57618 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313190AbSGYMsk>;
	Thu, 25 Jul 2002 08:48:40 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 25 Jul 2002 14:50:56 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
CC: Andre Hedrick <andre@linux-ide.org>, martin@dalecki.de,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1D0647598B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 02 at 14:08, Alan Cox wrote:

> +   OUT_BYTE(0x00, 0xCFB);
> +   OUT_BYTE(0x00, 0xCF8);
> +   OUT_BYTE(0x00, 0xCFA);
> +   if (IN_BYTE(0xCF8) == 0x00 && IN_BYTE(0xCF8) == 0x00) {
                                            ^^^^^
It should be 0xCFA according to arch/i386/pci/direct.c...
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
