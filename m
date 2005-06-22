Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVFVRWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVFVRWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVFVRTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:19:38 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:63634 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261750AbVFVRQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:16:48 -0400
X-ORBL: [63.202.173.158]
Date: Wed, 22 Jun 2005 10:16:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Valerio Vanni <valerio.vanni@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel: __alloc_pages: 0-order allocation failed
Message-ID: <337665.592cd517f5a62ef2c0b5181f0c5ea620.ANY@taniwha.stupidest.org>
References: <djtib1thpa0pm2oi60e7nci8au2rtkm98m@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <djtib1thpa0pm2oi60e7nci8au2rtkm98m@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 04:32:32PM +0200, Valerio Vanni wrote:

> I mean: is it simply a situation of excessive memory requests that is
> fixed by killing one or more processes (and the kernel is still alive
> as before) or the kernel is in some way locked up (in particular: is
> it necessary/better to reboot? Is there some risk of filesystem
> corruption?).

It's memory allocation failures.  This might not work until memory is
free but it shouldn't kill the kernel of be a huge problem if it's
just the result of one ore more processes being memory hungry
(ie. when those processes go away things should be fine).

It could also occur if there is a memory leak, in which case there is
a bug that needs to be fixed and a reboot would be needed (I would
only suspect that if it did it often and processes were not using much
memory though).
