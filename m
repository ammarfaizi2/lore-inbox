Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755907AbWKVN4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbWKVN4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbWKVN4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:56:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755907AbWKVN4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:56:52 -0500
Subject: Re: RFC/T: Trial fix for the bcm43xx - wpa_supplicant
	-	NetworkManager deadlock
From: Dan Williams <dcbw@redhat.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, Ray Lee <ray-lk@madrabbit.org>,
       Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <45634A4A.1040909@lwfinger.net>
References: <4561DBE0.2060908@lwfinger.net> <45628C05.405@madrabbit.org>
	 <45633FF8.6010209@lwfinger.net> <1164133962.3631.14.camel@johannes.berg>
	 <1164134201.3631.16.camel@johannes.berg>  <45634A4A.1040909@lwfinger.net>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 08:58:10 -0500
Message-Id: <1164203890.3474.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-21 at 12:49 -0600, Larry Finger wrote:
> Johannes Berg wrote:
> > On Tue, 2006-11-21 at 19:32 +0100, Johannes Berg wrote:
> > 
> >> I don't think this is the right thing to do.
> > 
> > Or put differently, this won't fix the problem if that "something:
> > that's triggering the deadlock happens while you're in the locked
> > section.
> 
> I'm going to install NM on my system to see if I can trigger the problem with lockdep enabled.

If you don't want to go that far, just run a bunch of "iwlist eth1 scan"
and "iwconfig eth1" over and over and you'll effectively simulate the
behavior of NM in this situation (although doing it a lot quicker than
NM likely).

Setting up a script to just run those two in parallel continuously is
probably a good test of any WE locking in a driver :)

Dan

> Larry

