Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbUBHTfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 14:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUBHTfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 14:35:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18660 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264356AbUBHTfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 14:35:08 -0500
Message-ID: <40268F5E.4050609@pobox.com>
Date: Sun, 08 Feb 2004 14:34:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Adrian Bunk <bunk@fs.tum.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 405] Amiga Hydra Ethernet new driver model
References: <200402081528.i18FSTrV026999@callisto.of.borg> <20040208184705.GW7388@fs.tum.de> <Pine.GSO.4.58.0402082000580.6076@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0402082000580.6076@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> But a quick look shows that very few drivers seem to mark their ID table array
> __devinitdata...


Yes, this highlights a recent problem with CONFIG_HOTPLUG.  These 
markers were removed when the "add PCI ids to your table dynamically" 
patch was added in 2.5.x.  The patch didn't require CONFIG_HOTPLUG, and 
fun ensued.  This got fixed (IIRC), but also many drivers had their 
__devinitdata markers removed.  This is a fuzzy area where Greg loves to 
make the case for removing  CONFIG_HOTPLUG completely :)

	Jeff



