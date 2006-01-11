Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWAKW0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWAKW0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWAKW0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:26:24 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14208 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932301AbWAKW0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:26:23 -0500
Date: Wed, 11 Jan 2006 23:26:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3
In-Reply-To: <20060111104520.42a766d1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0601112258250.11765@scrub.home>
References: <20060111042135.24faf878.akpm@osdl.org> <Pine.LNX.4.61.0601111924001.11765@scrub.home>
 <20060111104520.42a766d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Jan 2006, Andrew Morton wrote:

> Ignoring the objections of a long-standing and respected kernel developer
> is not a thing I like to do, but fortunately it's very rare.

I really hoped where would be a question before if there were outstanding 
issues.

> Can you summarise, yet again, in as few words as possible, what you find
> wrong with it?  I'd really like to understand, but there were waay too many
> lengthy emails..

The whole resolution issue is still outstanding. It basically assumes 
already high resolution timer and makes it hard to allow simple low 
resolution timer.

The rounding is broken for relative timer started on low resolution 
clocks. The run_hrtimer_queue() calls get_time() every interrupt, wasting 
time if that call should be slow (and could be avoided completely for low 
resolution timers).
I haven't even gotten to a number of small issues, because it's impossible 
to discuss even the general issues with Thomas. :-(

bye, Roman
