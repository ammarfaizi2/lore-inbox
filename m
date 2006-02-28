Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWB1OBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWB1OBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWB1OBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:01:41 -0500
Received: from main.gmane.org ([80.91.229.2]:2746 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750809AbWB1OBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:01:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergei Organov <osv@javad.com>
Subject: Re: o_sync in vfat driver
Date: Tue, 28 Feb 2006 16:52:29 +0300
Message-ID: <du1kj0$f1j$1@sea.gmane.org>
References: <op.s5cj47sxj68xd1@mail.piments.com>
	<op.s5jpqvwhui3qek@mail.piments.com>
	<op.s5kxhyzgfx0war@mail.piments.com>
	<op.s5kx7xhfj68xd1@mail.piments.com>
	<op.s5kya3t0j68xd1@mail.piments.com>
	<op.s5ky2dbcj68xd1@mail.piments.com>
	<op.s5ky71nwj68xd1@mail.piments.com>
	<op.s5kzao2jj68xd1@mail.piments.com>
	<op.s5lq2hllj68xd1@mail.piments.com>
	<20060227132848.GA27601@csclub.uwaterloo.ca>
	<1141048228.2992.106.camel@laptopd505.fenrus.org>
	<1141049176.18855.4.camel@imp.csi.cam.ac.uk>
	<1141050437.2992.111.camel@laptopd505.fenrus.org>
	<1141051305.18855.21.camel@imp.csi.cam.ac.uk>
	<op.s5ngtbpsj68xd1@mail.piments.com>
	<Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com>
	<op.s5nm6rm5j68xd1@mail.piments.com>
	<Pine.LNX.4.61.0602280745500.9291@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
> On Mon, 27 Feb 2006 col-pepper@piments.com wrote:
>
>> On Mon, 27 Feb 2006 22:32:07 +0100, linux-os (Dick Johnson)
>> <linux-os@analogic.com> wrote:
>>
[...]
> It takes about a second to erase a 64k physical sector. This is
> a required operation before it is written.
> Since the projected life of these new devices is about 5 to 10 million
> such cycles, (older NAND flash used in modems was only 100-200k) the
> writer would have to be running that "brand new device" for at least 5
> million seconds. Let's see:

What FLASH are you talking about? I work with NAND FLASH chips directly
in embedded projects, and for both Toshiba and Samsung NAND FLASH the
erase time of 128Kb (64K words) block is 2 milliseconds typical. Page
program time is 0.3 milliseconds typical, so, having 64 pages per block,
total erase-write block cycle is about 22ms.

Those chips indeed support about 100K program/erase cycles. Well, maybe
there are some new NAND FLASH chips that support more program/erase
cycles (just checked Samsung but found none), but I doubt they are 1000
times slower for block erase anyway.

-- Sergei.

