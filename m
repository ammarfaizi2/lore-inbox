Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVLPAky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVLPAky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLPAky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:40:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:660 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751223AbVLPAkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:40:53 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
In-Reply-To: <43A1E876.6050407@wolfmountaingroup.com>
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de>
	 <43A1DB18.4030307@wolfmountaingroup.com>
	 <1134688488.12086.172.camel@mindpipe>
	 <43A1E451.2090703@wolfmountaingroup.com>
	 <1134689197.12086.176.camel@mindpipe>
	 <43A1E876.6050407@wolfmountaingroup.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Dec 2005 00:38:47 +0000
Message-Id: <1134693527.21906.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-15 at 15:04 -0700, Jeff V. Merkey wrote:
> apply to kernel code.  calls from several of our apps (which use
> larger than 4K kernel space on a stack) 

Then you've got bugs anyway. In 8K stack mode that stack is shared with
the IRQ/BH/etc stack so you've only got 4K to play with. Its just more
random whether your box explodes.

