Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTH1WWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTH1WWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:22:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:34454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264418AbTH1WWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:22:22 -0400
Date: Thu, 28 Aug 2003 15:17:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Gibson <gothick@gothick.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Message-Id: <20030828151708.0b13dd82.rddunlap@osdl.org>
In-Reply-To: <200308282002.00758.gothick@gothick.org.uk>
References: <200308281548.44803.tomasz_czaus@go2.pl>
	<20030828084640.68fe827d.rddunlap@osdl.org>
	<200308282002.00758.gothick@gothick.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003 20:02:00 +0100 Matt Gibson <gothick@gothick.org.uk> wrote:

| On Thursday 28 Aug 2003 16:46, Randy.Dunlap wrote:
| > Use "parsemce" from here:
| >   http://www.codemonkey.org.uk/projects/parsemce/
| > to decode it.
| 
| Hi Randy,

| I'm guessing it'll parse it 
| from one format I don't have a clue about into a more verbose format I don't 
| have a clue about ;-)

That was insightful.  :(

| The format seems to have changed rather a lot since that was written.  All I 
| get is:
| 
| Aug 17 11:25:13 codewave kernel: MCE: The hardware reports a non fatal, 
| correctable incident occurred on CPU 0.
| Aug 17 11:25:13 codewave kernel: Bank 0: dc0000000000050b
| 
| ...but what parsemce seems to be expecting is:
| 
|  Sample kernel output..
|  Sep  4 21:43:41 hamlet kernel: CPU 0: Machine Check Exception: 
| 0000000000000004
| Sep  4 21:43:41 hamlet kernel: Bank 1: f600200000000152 at 7600200000000152
| Sep  4 21:43:41 hamlet kernel: Bank 2: d40040000000017a at 540040000000017a
| Sep  4 21:43:41 hamlet kernel: Kernel panic: CPU context corrupt
| 
| As a result, I'm still no more enlightened.  I can't quite figure out from 
| reading the parser what values to put where, as it seems to expect a few 
| more than I have.  Any tips?

Yes, the kernel has decided that your processor only has 1 Bank of
MCE register data to report.  I don't know how/why.  Sorry.

--
~Randy
