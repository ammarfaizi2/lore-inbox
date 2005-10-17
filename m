Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVJQTFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVJQTFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVJQTFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:05:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37282 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932261AbVJQTFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:05:01 -0400
Date: Mon, 17 Oct 2005 21:04:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux@horizon.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <20051017183834.32695.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.61.0510172050460.1386@scrub.home>
References: <20051017183834.32695.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2005 linux@horizon.com wrote:

> > - "timer API" vs "timeout API": I got absolutely no acknowlegement that 
> > this might be a little confusing and in consequence "process timer" may be 
> > a better name.
> 
> I have to disagree.  Once you grasp the desirability of having two kinds
> of timers, one optimized for the case where it does expire, and one
> optimized for the case where it is aborted or rescheduled before its
> expiration time, the timer/timeout terminology seems quite intuitive
> to me.

Thank you, that's exactly the confusion, I'd like to avoid.

The main difference is in their possible resolution: kernel timer are a 
low resolution, low overhead timer optimized for kernel needs and process 
timer have a larger resolution mainly for applications, but this also 
implies a larger overhead (i.e. more expensive locking).

bye, Roman
