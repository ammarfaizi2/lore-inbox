Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161212AbWAMAqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbWAMAqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWAMAqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:46:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43966 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932678AbWAMAqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:46:09 -0500
Date: Thu, 12 Jan 2006 19:46:00 -0500
From: Dave Jones <davej@redhat.com>
To: Adam Belay <ambx1@neo.rr.com>, Con Kolivas <kernel@kolivas.org>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060113004600.GB6883@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adam Belay <ambx1@neo.rr.com>, Con Kolivas <kernel@kolivas.org>,
	ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060112221133.GA11601@neo.rr.com> <20060112230315.GO19827@redhat.com> <20060113004236.GB11601@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113004236.GB11601@neo.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 07:42:36PM -0500, Adam Belay wrote:

 > > > It might be possible to do even a little better.  Currently, I'm developing a
 > > > new ACPI idle policy that tries to take advantage of the long time we may
 > > > be able to spend in a C3 state.
 > > 
 > > As soon as that usb timer hits (every 250ms iirc) you'll bounce back out
 > > of any low-power state you may be in. It's a bit craptastic that we do
 > > this, even if we don't have any USB devices plugged in.
 > 
 > I agree that's annoying, but isn't 250ms not often enough to make any
 > significant difference as far as power management is concerned?
 > Generally some bus master activity will come along in a shorter time frame,
 > causing a jump out of C3.

All I know is that when I removed the usb modules, the power usage stopped
fluctuating as often, and it spent longer times hovering around the 18-19W mark
instead of bouncing anywhere between 18-22W.

		Dave

