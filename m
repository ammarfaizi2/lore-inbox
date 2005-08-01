Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVHABno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVHABno (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 21:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVHABno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 21:43:44 -0400
Received: from tim.rpsys.net ([194.106.48.114]:3500 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261784AbVHABnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 21:43:43 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 02:43:23 +0100
Message-Id: <1122860603.7626.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 02:58 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/

I'm seeing a problem on ARM with -rc3-mm3 and -rc4-mm1. -rc3-mm2 and
-rc4 are fine and looking for the problem reveals the problems start
after these patches are applied:

> +page-fault-patches-optional-page_lock-acquisition-in.patch
> +page-fault-patches-optional-page_lock-acquisition-in-tidy.patch

The system appears to be ok and boots happily to a console but if you
load any graphical UI, the screen will blank and the process stops
working (tested with opie and and xserver+GPE). You can kill -9 the
process but you can't regain the console without a suspend/resume cycle
which performs enough of a reset to get it back. chvt and the console
switching keys don't respond.

I tried the patch mentioned in http://lkml.org/lkml/2005/7/28/304 but it
makes no difference.

Richard

