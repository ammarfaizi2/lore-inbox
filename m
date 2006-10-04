Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbWJDHu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWJDHu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWJDHu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:50:26 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:9175 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1161131AbWJDHuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:50:23 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Johannes Berg <johannes@sipsolutions.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Jeff Garzik <jeff@garzik.org>, jt@hpl.hp.com,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061003214038.GE23912@tuxdriver.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com>
	 <1159890876.20801.65.camel@mindpipe>
	 <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
	 <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
	 <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
	 <20061003214038.GE23912@tuxdriver.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 09:50:47 +0200
Message-Id: <1159948247.2817.28.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 17:40 -0400, John W. Linville wrote:

> Wireless developers, it's time to get d80211 ready to merge...or
> figure-out how to get nl80211 on the current stack...hmmm...

Actually, cfg80211/nl80211 are not really tied to the stack, the intent
always was to make them replace wext even for legacy drivers.

Hence, all legacy drivers need to do is assign their net_device's struct
ieee80211_ptr and register a wiphy operations structure (and profit).

johannes
