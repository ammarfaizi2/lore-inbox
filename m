Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVGNWcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVGNWcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVGNW3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:29:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:43743 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262860AbVGNW25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:28:57 -0400
Date: Fri, 15 Jul 2005 00:28:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] new human-time soft-timer subsystem
In-Reply-To: <20050714202629.GD28100@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0507150014200.3743@scrub.home>
References: <20050714202629.GD28100@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Jul 2005, Nishanth Aravamudan wrote:

> We no longer use jiffies (the variable) as the basis for determining
> what "time" a timer should expire or when it should be added. Instead,
> we use a new function, do_monotonic_clock(), which is simply a wrapper
> for getnstimeofday().

And suddenly a simple 32bit integer becomes a complex 64bit integer, which 
requires hardware access to read a timer and additional conversion into ns.
Why is suddenly everyone so obsessed with molesting something simple and 
cute as jiffies?

bye, Roman
