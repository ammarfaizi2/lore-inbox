Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWIKPaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWIKPaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWIKPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:30:24 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:56011 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751303AbWIKPaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:30:23 -0400
In-Reply-To: <20060911151730.GA25244@aepfle.de>
References: <20060911115354.GA23884@aepfle.de> <20060911151730.GA25244@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B0C84ED5-7F7A-4DF4-ADD5-9DB0DF641E42@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Prevent legacy io access on pmac
Date: Mon, 11 Sep 2006 17:30:12 +0200
To: Olaf Hering <olaf@aepfle.de>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> * add check for parport_pc, exit on pmac.
>
> How do I allow parport on PCI cards?

Use the parport_serial driver...  cards that are fixed at the
legacy address probably won't work at all on a PowerMac, the PCI
bridges would have to be set up specially and you'll run into all
kinds of problems.

Cards that have a parport with a configurable base address work
fine in a PowerMac.


Segher

