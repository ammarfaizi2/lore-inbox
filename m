Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUK3Ci0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUK3Ci0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUK3Chs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:37:48 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:18706 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261956AbUK3Ccp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:32:45 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Bernard Normier" <bernard@zeroc.com>
Cc: <jonathan@jonmasters.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Concurrent access to /dev/urandom
Date: Mon, 29 Nov 2004 18:31:50 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEFPACAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.61.0411300041290.816@mercury.sdinet.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 29 Nov 2004 18:08:14 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 29 Nov 2004 18:08:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 29 Nov 2004, Bernard Normier wrote:
>
> >>> I use /dev/urandom to generate UUIDs by reading 16 random bytes from
> >>> /dev/urandom (very much like e2fsprogs' libuuid).
> >>
> >> Why not use /dev/random for such data instead?
> >
> > A UUID generator that blocks from time to time waiting for
> entropy would not
> > be usable.
>
> Especially when used on a box without any effective entropy source - like
> praktically most cheap servers stashed away into some rack.

	Assuming most of your cheap servers are running some version of the Intel
Pentium or comparable, they have wonderful entropy sources. Nobody can
predict the oscillator offset between the crystals in the network cards on
both ends and the TSC. This entropy source is mined by the kernel.

	DS


