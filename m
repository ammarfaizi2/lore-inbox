Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbTDCIV5>; Thu, 3 Apr 2003 03:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTDCIV5>; Thu, 3 Apr 2003 03:21:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:47354 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S263320AbTDCIV4>; Thu, 3 Apr 2003 03:21:56 -0500
Date: Thu, 3 Apr 2003 09:35:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Robert White <rwhite@casabyte.com>
cc: Christoph Rohland <cr@sap.com>, <tomlins@cam.org>, CaT <cat@zip.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGAEOMCFAA.rwhite@casabyte.com>
Message-ID: <Pine.LNX.4.44.0304030932330.1551-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Robert White wrote:

> This (using swap as part of the tmpfs type system) is what happens on a Sun.
> I was disappointed (surprised even) in the Linux implementations because
> mounting a truly temporary /tmp was what I wanted it for.

The Linux implementation of tmpfs _does_ use swap:
tmpfs data pages go out to swap under memory pressure.

> I would like to see a tmpfs (swapfs?) that did presume that files not in use
> (lately?) would migrate out of my valuable RAM and onto the super-cheap swap
> device.

