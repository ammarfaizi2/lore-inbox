Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTILX0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTILX0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:26:10 -0400
Received: from holomorphy.com ([66.224.33.161]:39614 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261956AbTILXYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:24:01 -0400
Date: Fri, 12 Sep 2003 16:25:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Breno <brenosp@brasilsec.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stack overflow
Message-ID: <20030912232507.GV4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Breno <brenosp@brasilsec.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br> <20030912165047.Z18851@schatzie.adilger.int> <20030912230601.GU4306@holomorphy.com> <1063408711.6740.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063408711.6740.4.camel@dhcp23.swansea.linux.org.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 00:06, William Lee Irwin III wrote:
>> What he actually wants is in-kernel user stack overflow checking, which
>> is basically impossible since user stacks are demand paged. He's been
>> told this before and failed to absorb it.

On Sat, Sep 13, 2003 at 12:18:32AM +0100, Alan Cox wrote:
> We will fault and error on a user stack exceed. You need to use
> sigaltstack to catch it for obvious reasons. You can also use mmap and
> drop in red zones on user space stacks

Stack rlimits are fine and we already do those; the rest sounds like
something userspace has to do.


-- wli
