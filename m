Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUCKOsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUCKOsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:48:41 -0500
Received: from colin2.muc.de ([193.149.48.15]:52498 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261398AbUCKOsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:48:31 -0500
Date: 11 Mar 2004 15:48:29 +0100
Date: Thu, 11 Mar 2004 15:48:29 +0100
From: Andi Kleen <ak@muc.de>
To: Mickael Marchand <marchand@kde.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, dm@uk.sistina.com
Subject: Re: 2.6.4-mm1
Message-ID: <20040311144829.GA22284@colin2.muc.de>
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403111445.35075.marchand@kde.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hmm right now, dm/lvm absolutely does not work on amd64/32 bits. all ioctls 
> calls are failling...

With no messages in the log? 

Maybe they have broken data structures again, most likely
because of different long long alignment. A lot of people
who attempt to design data structures that don't need translation
get that wrong unfortunately. 

Emulating that stuff would be hard unfortunately because it has an rather
over complicated ioctl structure that would be hard to write sane
emulation code for.

Complain to the DM maintainers.

-Andi
