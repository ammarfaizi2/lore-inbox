Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVLPOt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVLPOt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLPOt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:49:57 -0500
Received: from smtp13.wanadoo.fr ([193.252.22.54]:17709 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S932292AbVLPOt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:49:56 -0500
X-ME-UUID: 20051216144955162.03F137000095@mwinf1309.wanadoo.fr
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Xavier Bestel <xavier.bestel@free.fr>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
In-Reply-To: <Pine.LNX.4.61.0512160927390.30350@chaos.analogic.com>
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de>
	 <43A1DB18.4030307@wolfmountaingroup.com>
	 <1134688488.12086.172.camel@mindpipe>
	 <43A1E451.2090703@wolfmountaingroup.com>
	 <1134689197.12086.176.camel@mindpipe>
	 <Pine.LNX.4.61.0512160927390.30350@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1134744579.6493.1.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 16 Dec 2005 15:49:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 15:39, linux-os (Dick Johnson) wrote:

> Throughout the past two years of 4k stack-wars, I never heard why
> such a small stack was needed (not wanted, needed).

Because after some prolonged uptime, memory can be heavily fragmented.
In this case an order-0 allocation will always succeed (as long as some
memory is free), whereas an order-1 allocation may easily fail.

	Xav


