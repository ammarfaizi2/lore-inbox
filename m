Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVBLNKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVBLNKO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 08:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVBLNKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 08:10:14 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:22752 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261400AbVBLNJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 08:09:58 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [RFC] Reliable video POSTing on resume
To: Kendall Bennett <kendallb@scitechsoft.com>, mjg59@srcf.ucam.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 12 Feb 2005 14:10:42 +0100
References: <fa.fmtnc0t.131o1g5@ifi.uio.no> <fa.eiu608d.10522qb@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1Czx2p-0000ih-I7@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett <kendallb@scitechsoft.com> wrote:

> Laptops are a little different as they will make calls from the Video
> BIOS into the system BIOS, so you need to make sure that the system BIOS
> is also available in the execution environment.

Any video BIOS (especially EGA) may call system BIOS functions, e.g. via the
old INT10 (which will get copied to INT42).

HGC and VGA are in the system BIOS. They don't need magic, but they need to
be initialized on order to keep the monitor from burning. On the other hand,
they used to be initialised correctly.
