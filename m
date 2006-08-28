Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWH1NzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWH1NzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 09:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWH1NzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 09:55:05 -0400
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:62875 "EHLO
	p02c11o145.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750825AbWH1NzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 09:55:03 -0400
Date: Mon, 28 Aug 2006 16:53:58 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060828135358.GC24261@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060825110441.GB8538@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825110441.GB8538@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 28 Aug 2006 14:00:17.0343 (UTC) FILETIME=[4AB784F0:01C6CAAA]
X-Spam: [F=0.0175580016; S=0.017(2006081701)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, it turns out the problem was with running SATA drive in AHCI mode.

After applying the following patch from Forrest Zhao
http://lkml.org/lkml/2006/7/20/56
both suspend to disk and suspend to ram work fine now.
This patch is going into 2.6.18, isn't it?

Huge thanks to Thomas Glanzman for help in tracking this down.
You rock.

-- 
MST
