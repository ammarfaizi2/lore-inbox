Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRIYVyh>; Tue, 25 Sep 2001 17:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIYVy1>; Tue, 25 Sep 2001 17:54:27 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:48523
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S271741AbRIYVyR>; Tue, 25 Sep 2001 17:54:17 -0400
Date: Tue, 25 Sep 2001 14:54:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jim Potter <jrp@wvi.com>, linux-kernel@vger.kernel.org
Subject: Re: question from linuxppc group
Message-ID: <20010925145433.D11230@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3BB0E2F2.CD668D18@wvi.com> <20010925213557.7782@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925213557.7782@smtp.adsl.oleane.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 11:35:57PM +0200, Benjamin Herrenschmidt wrote:
> >We have  a host bridge (plus PIC, mem ctlr, etc.) that is essentially
> >identical
> >for ppc and mips.  Where is the best place to put the code since we
> >don't want to
> >duplicate it for both architectures?
> 
> Well, most of the PCI & interrupt frameworks are mostly arch specific.
> I can't tell for MIPS, but the way you setup a PCI host bridge on PPC
> was written by me and Paulus without looking at MIPS. 

Well, MIPS has been looking at us a bit I know.  Also, the patch that
Mark/Matt did uses the pci_auto stuff for setting up the bridges (iirc
thats what that code is for anyhow :)) and MIPS has been using that
as well of late, tho their gt64120 bits don't look like they use it
right now.

> I don't think there is real need to have common code here. Maybe some
> common definitions (register defs for example) could go into a linux/*.h
> file.

If nothing else, yeah.  And all of the drivers into drivers/.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
