Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUGZN5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUGZN5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUGZN5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:57:41 -0400
Received: from ai181-26.aiinet.com ([205.245.181.26]:34944 "EHLO
	aiexchange.ai.aiinet.com") by vger.kernel.org with ESMTP
	id S265396AbUGZN5R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:57:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] get_random_bytes returns the same on every boot
Date: Mon, 26 Jul 2004 09:57:10 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFC2F@aiexchange.ai.aiinet.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] get_random_bytes returns the same on every boot
Thread-Index: AcRwQ8wUAT76ixO3Rmym6D+yRq5zWQC0/K6Q
From: "Eble, Dan" <DanE@aiinet.com>
To: "Balint Marton" <cus@fazekas.hu>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balint Marton wrote:
> At boot time, get_random_bytes always returns the same 
> random data, as if there were a constant random seed.
> packet with always the same transaction ID. (If you have 
> more than one computers, and they are booting at the
> same time, then this is a big problem)

If many systems are booting at the same time, is seeding with the system
time really an appropriate solution?  Shouldn't some system-specific
value also contribute to the randomization?
