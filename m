Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbUKQXL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbUKQXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUKQXI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:08:56 -0500
Received: from dsl-213-023-007-213.arcor-ip.net ([213.23.7.213]:50180 "EHLO
	be3.lrz.7eggert.dyndns.org") by vger.kernel.org with ESMTP
	id S262668AbUKQXHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:07:22 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: vm-pageout-throttling.patch: hanging in throttle_vm_writeout/blk_congestion_wait
To: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@nurfuerspam.de
Date: Thu, 18 Nov 2004 00:07:37 +0100
References: <fa.hmuv5gp.g5krg5@ifi.uio.no> <fa.c8odfd2.1a3mtig@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CUYtl-0001Ga-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Does Andrew's approach prevent putting swap on a compressed file (useful
> for reiser4 once the compression plugin is stable, not reiserfs)?

No, it's prevented by having a sane mind. Compression might be OK for swap,
but a compressed file will compete for physical disk space - and lose.
As long as the swap system doesn't know it's going to happen, you're going
to lose, too.
-- 
Orbiting [..] is a planet whose ape-descended life forms are so
amazingly primitive that they still think digital watches are a
pretty neat idea.  --  "The Hitchhiker's Guide to the Galaxy"
