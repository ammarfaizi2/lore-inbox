Return-Path: <linux-kernel-owner+w=401wt.eu-S1751636AbXACAYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbXACAYA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbXACAYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:24:00 -0500
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:2379 "EHLO
	hiauly1.hia.nrc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbXACAX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:23:58 -0500
X-Greylist: delayed 1282 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 19:23:58 EST
Message-Id: <200701030002.l0302Vx5017621@hiauly1.hia.nrc.ca>
Subject: Re: [parisc-linux] [RFC][PATCH] use cycle_t instead of u64 in struct
To: deller@gmx.de (Helge Deller)
Date: Tue, 2 Jan 2007 19:02:31 -0500 (EST)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
In-Reply-To: <200701022233.25697.deller@gmx.de> from "Helge Deller" at Jan 2, 2007 10:33:25 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The 32bit and 64bit PARISC Linux kernels suffers from the problem, that the gettimeofday() call sometimes returns non-monotonic times.

This certainly needs to be fixed.  I see stuff like this from ping:

64 bytes from 132.246.100.193: icmp_seq=19 ttl=255 time=0.4 ms
64 bytes from 132.246.100.193: icmp_seq=20 ttl=255 time=429496729.5 ms

tar also occasionally prints warning about times.  This is with a
32bit kernel.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
