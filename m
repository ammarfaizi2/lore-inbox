Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWISGGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWISGGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWISGGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:06:43 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:48800 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964860AbWISGGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:06:42 -0400
Message-ID: <450F88F0.307@garzik.org>
Date: Tue, 19 Sep 2006 02:06:40 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org>
In-Reply-To: <20060917074929.GD25800@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't really like this port_tbl approach.  I think it complicates 
things too much.

Direct indexing should be fine.  For the non-linear case, just make sure 
the non-existent ports are always dummy ports.  If the driver directly 
references a port we know isn't there, that's just an AHCI bug to be 
fixed...




