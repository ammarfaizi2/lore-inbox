Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbUBZT16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUBZT0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:26:44 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:35269 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262943AbUBZT0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:26:05 -0500
Date: Thu, 26 Feb 2004 14:25:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Jim Deas <jdeas0648@jadsystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel disables interrupts
In-Reply-To: <200402261025.AA3240886544@jadsystems.com>
Message-ID: <Pine.LNX.4.58.0402261423210.30536@montezuma.fsmlabs.com>
References: <200402261025.AA3240886544@jadsystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Jim Deas wrote:

> I am trouble shooting a new driver and have found a new
> kernel item that makes trouble shooting a bit harder.
> When I unload my test driver and before I can reload it
> (reseting the interrut controls)the Kernerl disables
> the chattering interrupt.
> Once the kernel has disable a spurious interrupt is there
> a way to get it back?

I take it you're referring to 2.6? Before you disable this feature (doable
via kernel parameter noirqdebug) be sure that you're disabling your device
before exiting the driver.
