Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTI2TQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264521AbTI2TQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:16:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35341 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S264520AbTI2TQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:16:08 -0400
Date: Mon, 29 Sep 2003 21:10:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Michael Hunold <hunold@convergence.de>
cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@fs.tum.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] select for drivers/media
In-Reply-To: <3F787A90.7020706@convergence.de>
Message-ID: <Pine.LNX.4.44.0309292100430.8124-100000@serv>
References: <20030928160536.GJ15338@fs.tum.de> <3F774CCC.3040707@convergence.de>
 <20030928212630.GS15338@fs.tum.de> <20030929173021.GA1762@kroah.com>
 <3F787A90.7020706@convergence.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Sep 2003, Michael Hunold wrote:

> So here it comes: The idea is to allow the user to basically select
> everything. If a subsystem or utitlity stuff is needed (NET, INET, PCI, USB, I2C)
> it's selected automatically.

Please don't use select for something like PCI or NET, if e.g. PCI is not 
selected no pci driver should be visible or you annoy users which don't 
have a pci bus, but have to wade through thousands of nonrelevant drivers.

bye, Roman

