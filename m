Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTDVVwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263878AbTDVVwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:52:40 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59410 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263876AbTDVVwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:52:39 -0400
Date: Tue, 22 Apr 2003 17:58:44 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Dave Mehler <dmehler26@woh.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.68 kernel no initrd
In-Reply-To: <1050859494.595.4.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.3.96.1030422175506.31749B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2003, Felipe Alfaro Solana wrote:

> I don't have experience with initrd, but why would you want a initrd?
> Can't you simply build into the kernel the required pieces to mount the
> root filesystem and leave the rest as loadable modules?

As long as you are suporting or testing a small number of configurations,
say less than two, initrd buys not much. But using all modules allows you
to support a new config just by rebuilding initrd, vastly faster than
building a kernel on most machines. And for a vendor doing a distribution
it is a huge win.

Not to mention some drivers work differently when loaded as modules,
loading as modules allows control of the device scans, etc, etc. It's just
more flexible.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

