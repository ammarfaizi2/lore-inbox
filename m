Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTFMCKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 22:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTFMCKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 22:10:54 -0400
Received: from lorien.emufarm.org ([66.93.131.57]:2458 "EHLO
	lorien.emufarm.org") by vger.kernel.org with ESMTP id S265061AbTFMCKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 22:10:53 -0400
Date: Thu, 12 Jun 2003 19:24:36 -0700
From: Danek Duvall <duvall@emufarm.org>
To: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RTC causes hard lockups in 2.5.70-mm8
Message-ID: <20030613022436.GF7308@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	"Nathaniel W. Filardo" <nwf@andrew.cmu.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 10:12:06PM -0400, Nathaniel W. Filardo wrote:

> If I set CONFIG_RTC=m and rebuild, when the kernel autoloads rtc.ko the
> system immediately locks hard, not responding even to magic SysRq series.
> Backing out either of the rtc-* patches from -mm8 does not seem to fix the
> problem.
> 
> Hardware is a Fujitsu P2120 with Transmeta TM8500 with ALi chipset:

I saw this on the same hardware on 2.4.21-rc7-ac1, and I've seen a
report of the same on -rc1-ac3, but not on module loading, on accessing
the driver.  The problem doesn't seem to be present when running the non
-acX kernels.

Alan asked whether it was a specific in or out instruction in the
driver, but I don't know how to find out.

Danek
