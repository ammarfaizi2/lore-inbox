Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbTDCUoF 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263449AbTDCUoF 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:44:05 -0500
Received: from [209.63.254.226] ([209.63.254.226]:33797 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP
	id S262611AbTDCUoE 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:44:04 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "Christoph Rohland" <cr@sap.com>, <tomlins@cam.org>,
       "CaT" <cat@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Date: Thu, 3 Apr 2003 12:55:18 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGMEAGCGAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0304030932330.1551-100000@localhost.localdomain>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm, I think, on reflection, that I knew that because of having encountered
the swapoff problem after putting a bunch of stuff in a tmpfs...

Regardless,

Since the tmpfs occupies both ram and swap, then having the absolute size
limit based only on ram seems odd.

IMHO of course 8-)

Rob.


-----Original Message-----
From: Hugh Dickins [mailto:hugh@veritas.com]
Sent: Thursday, April 03, 2003 12:35 AM
To: Robert White
Cc: Christoph Rohland; tomlins@cam.org; CaT;
linux-kernel@vger.kernel.org
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 /
2.4.20-pre2)


On Wed, 2 Apr 2003, Robert White wrote:

> This (using swap as part of the tmpfs type system) is what happens on a
Sun.
> I was disappointed (surprised even) in the Linux implementations because
> mounting a truly temporary /tmp was what I wanted it for.

The Linux implementation of tmpfs _does_ use swap:
tmpfs data pages go out to swap under memory pressure.

> I would like to see a tmpfs (swapfs?) that did presume that files not in
use
> (lately?) would migrate out of my valuable RAM and onto the super-cheap
swap
> device.

