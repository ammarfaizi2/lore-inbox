Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUIAMa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUIAMa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUIAMa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:30:58 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:25311 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266289AbUIAMaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:30:46 -0400
Message-ID: <35fb2e59040901053015051ab9@mail.gmail.com>
Date: Wed, 1 Sep 2004 13:30:45 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "prasad@atc.tcs.co.in" <prasad@atc.tcs.co.in>
Subject: Re: Embedded Linux :: How different is it?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <51980.203.200.212.145.1094033022.squirrel@203.200.212.145>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <51980.203.200.212.145.1094033022.squirrel@203.200.212.145>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 15:33:42 +0530 (IST), prasad@atc.tcs.co.in
<prasad@atc.tcs.co.in> wrote:

> am sorry if its irrelevant here but i have always had this doubt
> and this doubt is growing stronger as i see more and more embedded
> linux based companies coming up!

Embedded Linux companies are all about offering extra value-added
services. Anyone can go read one of the limited number of books on
Embedded Linux, or one of the many on the kernel itself (Linux Kernel
Development is a good introductory read because it's - as the folks I
work with would say - a manageable size and also a fun read at the
same time) and either roll their own environment from scratch or use
tools such as crosstool and PTXdist to make their life easier.
Montavista (and the various other available embedded vendors) take the
effort out of the process by supplying the toolchains and kernel ports
so that developers don't have to figure this all out in the limited
time that they usually have available - especially those unfamiliar
with using Linux who have a six month deadline.

So there's a bandwaggon right now and if you look at the various
surveys (VDC reckon the market for embedded Linux devices will double
between 2003 and 2006), for example on the Linux Devices market
snapshot, you can see that no one vendor currently has a majority of
the market out there. You have to judge each offering on its own
merits.

> How different is a embedded linux kernel from the normal mainstream

Functionally it is identical but the compilation options will have
been adjusted to remove unwanted code for memory footprint or
performance reasons. The kernel might have been built using the newer
embedded specifc options (e.g. to remove certain processor support)
and it might actually turn out that the ucLinux 2.4 kernel tree is in
use on devices where there is no MMU. The kernel will also likely have
a bunch of patches that for whatever reason are available but not in
the stock kernel as nobody else wants to use them.

The kernel you get given by device manufacturer X is not magically
different from a stock kernel but just a little patched and built with
whatever device they have in mind.

> one. e.g. I have seen linux run on a mobile phone.

For example using an ARM7TDMI type core or something similar.

> When i buy it, am i not entitled to get the source-code???

Of course you can. This whole issue has been discussed before - your
best bet is to give them a call or send them an email and ask them for
a link to the sourcecode.

Then try to perhaps get somewhere with persuading them to honour their
GPL commitment.

Various projects, e.g. busybox, maintain a hall of shame and you'll
always find somewhere like slashdot to moan about company Y.
Unfortunately this does not mean that they will actually every release
the source (few of us have the resources to go suing every vendor we
buy devices from today - there are folks that will do it and certainly
community pressure but at the end of the day things can drag out for a
very long time trying to get the matter resolved properly) nor that
you'll find out exactly what they're using without dissecting the
images loaded on the flash chips in the device.

Jon.
