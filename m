Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbTF1Rs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 13:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTF1Rs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 13:48:26 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:53262 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265256AbTF1RsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 13:48:25 -0400
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Martin Schlemmer <azarah@gentoo.org>,
       Roberto Orenstein <rstein@brturbo.com>
In-Reply-To: <200306281516.12975.kernel@kolivas.org>
References: <200306281516.12975.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1056823357.597.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 28 Jun 2003 20:02:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-28 at 07:16, Con Kolivas wrote:
> The interactivity for tasks is based on the sleep avg accumulated divided by 
> the running time of the task. However since the accumulated time is not 
> linear with time it now works on the premise that running time is an 
> exponential function entirely. Pat Erley was the genius who implemented this 
> simple exponential function in surprisingly low overhead integer maths.
> 
> Also added was some jiffy wrap logic (as if anyone would still be running my 
> patch in 50 days :P).
> 
> Long sleepers were reclassified as idle according to the new exponential 
> logic.
> 
> If you test, please note this works better at 1000Hz.

Currently testing on 2.5.73-mm2, with both patches (patch-O1int and
patch-granularity) plus HZ=1000. The result is quite impressive. Under
load, X still suffer a little lag and behaves a little worse than the
combo patch from Mike Galbraith + Ingo, but now XMMS doesn't skip even
when clicking a link inside Evolution.

Please, let me more time to work with this new patched kernel a little
bit more to see if I can find any strange issues.

