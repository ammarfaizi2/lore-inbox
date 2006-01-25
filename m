Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWAYML1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWAYML1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 07:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWAYML1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 07:11:27 -0500
Received: from mail.suse.de ([195.135.220.2]:13459 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751135AbWAYML0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 07:11:26 -0500
Date: Wed, 25 Jan 2006 13:11:25 +0100
From: Olaf Kirch <okir@suse.de>
To: Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: e100 oops on resume
Message-ID: <20060125121125.GH5465@suse.de>
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125090240.GA12651@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 10:02:40AM +0100, Olaf Kirch wrote:
> I'm not sure what the right fix would be. e100_resume would probably
> have to call e100_alloc_cbs early on, while e100_up should avoid
> calling it a second time if nic->cbs_avail != 0. A tentative patch
> for testing is attached.

Reportedly, the patch fixes the crash on resume.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
