Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbTGOOI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268626AbTGOOI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:08:26 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:696
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S268486AbTGOOIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:08:24 -0400
Date: Tue, 15 Jul 2003 10:23:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver poll method
Message-ID: <20030715142314.GA13207@gtf.org>
References: <7A25937D23A1E64C8E93CB4A50509C2A0179B6E2@stca204a.bus.sc.rolm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0179B6E2@stca204a.bus.sc.rolm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 07:03:23AM -0700, Bloch, Jack wrote:
> I am implementing a poll method in a driver. I have defined a queue which I
> put into a wait table with a call to poll_wait. I also have my own DMA input
> list which is very specific to my device. I want my application to sleep in
> a suspended state until my device writes some data into the input list. Is
> it not so that the Kernel should periodically call my poll routine after my
> application calls select (until the select timer expires or as in my case, I
> specify a NULL value for the timeout). Please CC me directly on any
> responses.

drivers/sounds/via82cxxx_audio and several other audio drivers have
excellent examples of working poll(2) support.

The basic idea is that you set up the poll table, then the kernel does
the waiting...

	Jeff



