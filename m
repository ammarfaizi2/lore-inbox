Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSJ2Rb1>; Tue, 29 Oct 2002 12:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSJ2Rb1>; Tue, 29 Oct 2002 12:31:27 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:47366 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S262210AbSJ2Rb0>; Tue, 29 Oct 2002 12:31:26 -0500
Date: Tue, 29 Oct 2002 12:11:03 -0500 (EST)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Khalid Aziz <khalid@fc.hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Retrieve configuration information from kernel
In-Reply-To: <E186ZA8-00086R-00@lyra.fc.hp.com>
Message-ID: <Pine.LNX.4.10.10210291204590.28595-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Khalid Aziz wrote:

> I am including a revised patch that allows a user to embed kernel
> configuration in the kernel and retrieve it later either from a running
> kernel or from the kernel image file. This is an enhancement to Randy's
> patch that was discussed on LKML before and is part of -ac series
> kernels.
> 
> This patch provides three choices for embedding kernel configuration:
> 
> 1. Include configuration in running kernel image. This adds to the
> footprint of the running kernel but allows configuration to be retrieved
> using "cat /proc/ikconfig/config".

Have you considered compressing the config info in order to reduce
the space wastage in the loaded kernel image? Could easily be 10's of KB 
(not that that's a lot these days). The info would then be retrieved via 
"gunzip -c", et al. instead of a simple "cat".

--
Paul

