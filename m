Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUAFIMC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUAFILg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:11:36 -0500
Received: from colin2.muc.de ([193.149.48.15]:56338 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266096AbUAFILK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:11:10 -0500
Date: 6 Jan 2004 09:12:03 +0100
Date: Tue, 6 Jan 2004 09:12:03 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040106081203.GA44540@colin2.muc.de>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you ahve a proper e820 map, then it should work correctly, with 
> anything that is RAM being marked as such (or being marked as "reserved").

Every e820 map i've seen did not have the AGP aperture marked reserved.
It is just an undescribed hole.  In fact when you mark the aperture in the
e820 map the Linux AGP driver stops working, it relies on it being
in an undescribed hole.

This means you cannot just reuse holes. And there is no other way to get
mapping space.

-Andi
