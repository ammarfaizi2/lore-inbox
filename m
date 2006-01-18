Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWARPdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWARPdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWARPdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:33:45 -0500
Received: from mail1.kontent.de ([81.88.34.36]:43182 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1030348AbWARPdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:33:44 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] hci_usb: implement suspend/resume
Date: Wed, 18 Jan 2006 16:34:08 +0100
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, marcel@holtmann.org,
       maxk@qualcomm.com, linux-kernel@vger.kernel.org,
       bluez-devel@lists.sourceforge.net
References: <1137540084.4543.15.camel@localhost> <200601181425.35524.oliver@neukum.org> <1137593621.4543.22.camel@localhost>
In-Reply-To: <1137593621.4543.22.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181634.08869.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 18. Januar 2006 15:13 schrieb Johannes Berg:
> On Wed, 2006-01-18 at 14:25 +0100, Oliver Neukum wrote:
> 
> > This patch is wrong. usb_kill_urb() will sleep. You must not use it under
> > a spinlock.
> 
> Whoops. Good catch. I'll have to analyse the logic with the lists being
> used here (and probably add a temporary list). Will try to get a new
> patch until tomorrow.
> 
> [side note: how about adding might_sleep() to usb_kill_urb? Then I'd at
> least have noticed this right away]

Good idea.

	Regards
		Oliver
