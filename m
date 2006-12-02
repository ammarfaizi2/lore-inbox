Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162814AbWLBFRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162814AbWLBFRX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 00:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162815AbWLBFRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 00:17:23 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:16532 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1162814AbWLBFRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 00:17:23 -0500
X-YMail-OSG: wVnFzEEVM1kFSHdTMb3jGTZJUgaPifhXoJUTSTUDR5HO4Re24a80kCiCBAh_xmI.aORs375BpMpyrbdP1UDBFooKoEXrfYiXkLYELcZ3L56gI85lIwtDUw--
Date: Fri, 1 Dec 2006 21:17:20 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061202051720.GA12580@tuatara.stupidest.org>
References: <4570CF26.8070800@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4570CF26.8070800@scientia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 01:56:06AM +0100, Christoph Anton Mitterer wrote:

> I found a severe bug mainly by fortune because it occurs very
> rarely.  My test looks like the following: I have about 30GB of
> testing data on my harddisk,... I repeat verifying sha512 sums on
> these files and check if errors occur.

Heh, I see this also with an Tyan S2866 (nforce4 chipset).  I've been
aware something is a miss for a while because if I transfer about 40GB
of data from one machine to another there are checksum mismatches and
some files have to be transfered again.

I've kept quite about it so far because it's not been clear what the
cause is and because i can mostly ignore it now that I checksum all my
data and check after xfer that it's sane (so I have 2+ copies of all
this stuff everywhere).

> One test pass verifies the 30GB 50 times,... about one to four
> differences are found in each pass.

Sounds about the same occurance rate I see, 30-40GB xfer, one or two
pages (4K) are wrong.

> The corrupted data is not one single completely wrong block of data
> or so,.. but if you look at the area of the file where differences
> are found,.. than some bytes are ok,.. some are wrong,.. and so on
> (seems to be randomly).

For me it seems that a single block in the file would be bad and the
rest OK --- we I'm talking about 2 random blocks in 30BG or so.
