Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269460AbUJLFWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269460AbUJLFWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 01:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUJLFWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 01:22:30 -0400
Received: from holomorphy.com ([207.189.100.168]:61828 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269460AbUJLFW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 01:22:28 -0400
Date: Mon, 11 Oct 2004 22:22:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
Message-ID: <20041012052210.GW9106@holomorphy.com>
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain> <416B6594.5080002@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416B6594.5080002@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>> The OOM killer is a heuristic. 

On Mon, Oct 11, 2004 at 11:03:16PM -0600, Chris Friesen wrote:
> Sure, but presumably it's a bad thing for a user with no priorities to be 
> able to lock up a machine by running two tasks?  I'm not complaining that 
> its killing the wrong thing, I'm complaining that the machine locked up.

Alan Cox wrote:
>> Switch the machine to strict accounting
>> and it'll kill or block memory access correctly.

On Mon, Oct 11, 2004 at 11:03:16PM -0600, Chris Friesen wrote:
> I must be able to run an app that uses over 90% of system memory, and calls 
> fork().  I was under the impression this made strict accounting unfeasable?

Not so. Just add enough swapspace to act as the backing store for the
aggregate anonymous virtualspace.


-- wli
