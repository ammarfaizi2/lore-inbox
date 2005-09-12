Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVILVf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVILVf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVILVf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:35:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58525 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932150AbVILVf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:35:58 -0400
Subject: Re: Oops 2.6.13-git6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050912180038.GE2382@mail.muni.cz>
References: <20050912102011.GA2379@mail.muni.cz>
	 <1126530670.30449.64.camel@localhost.localdomain>
	 <20050912180038.GE2382@mail.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 23:01:15 +0100
Message-Id: <1126562475.30449.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-12 at 20:00 +0200, Lukas Hejtmanek wrote:
> However, in the case of 2 IDE channels hotplug program works with unregister and
> rescan commands. I think there is still problem with DMA, but it works partly.

In a tiny subset of cases and for PIO modes only for devices that match
IDE generic PIO interfaces, providing the interface is not boot
detected, you don't remove it when in use and the moon is in the right
phase.


> Another issue, when cdrecord finalizes DVD or CD, then whole IDE channel is
> blocked. Is that hardware problem or some preemption problem in kernel?

This is an IDE protocol limitation. See the cdrecord manual for other
options if you want to avoid that occurring.

