Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274590AbRIYVef>; Tue, 25 Sep 2001 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274631AbRIYVeZ>; Tue, 25 Sep 2001 17:34:25 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:13842 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S274603AbRIYVeL>; Tue, 25 Sep 2001 17:34:11 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jim Potter <jrp@wvi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: question from linuxppc group
Date: Tue, 25 Sep 2001 23:36:19 +0200
Message-Id: <20010925213619.29454@smtp.adsl.oleane.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We have  a host bridge (plus PIC, mem ctlr, etc.) that is essentially
>identical
>for ppc and mips.  Where is the best place to put the code since we
>don't want to
>duplicate it for both architectures?

Well, most of the PCI & interrupt frameworks are mostly arch specific.
I can't tell for MIPS, but the way you setup a PCI host bridge on PPC
was written by Paulus and me without looking at MIPS. 

I don't think there is real need to have common code here. Maybe some
common definitions (register defs for example) could go into a linux/*.h
file.

Ben.

