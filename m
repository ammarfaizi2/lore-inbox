Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSGYNUE>; Thu, 25 Jul 2002 09:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGYNUE>; Thu, 25 Jul 2002 09:20:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63484 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313558AbSGYNTC>; Thu, 25 Jul 2002 09:19:02 -0400
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Andre Hedrick <andre@linux-ide.org>, martin@dalecki.de,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1D0647598B@vcnet.vc.cvut.cz>
References: <1D0647598B@vcnet.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 15:34:25 +0100
Message-Id: <1027607665.9488.75.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 13:50, Petr Vandrovec wrote:
> On 25 Jul 02 at 14:08, Alan Cox wrote:
> 
> > +   OUT_BYTE(0x00, 0xCFB);
> > +   OUT_BYTE(0x00, 0xCF8);
> > +   OUT_BYTE(0x00, 0xCFA);
> > +   if (IN_BYTE(0xCF8) == 0x00 && IN_BYTE(0xCF8) == 0x00) {
>                                             ^^^^^
> It should be 0xCFA according to arch/i386/pci/direct.c...

Correct. Martin I agree with this change.

