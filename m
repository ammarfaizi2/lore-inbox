Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbTEGOgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTEGOgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:36:08 -0400
Received: from holomorphy.com ([66.224.33.161]:46479 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263393AbTEGOfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:35:17 -0400
Date: Wed, 7 May 2003 07:47:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Torsten Landschoff <torsten@debian.org>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507144736.GE8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Torsten Landschoff <torsten@debian.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507143315.GA6879@stargate.galaxy>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 03:56:57PM +0200, J?rn Engel wrote:
>> Agreed, partially. There is the current issue of the kernel stack
>> being just 8k in size and no decent mechanism in place to detect a
>> stack overflow. And there is (arguably) the future issue of the kernel
>> stack shrinking to 4k.

On Wed, May 07, 2003 at 04:33:15PM +0200, Torsten Landschoff wrote:
> Pardon my ignorance, but why is the kernel stack shrinked to just a few
> kilobytes? With 256MB of RAM in a typical desktop system it shouldn't
> be a problem to use 256KB from that as the stack, but I am sure there
> are good reasons to shrink it. 
> Just curious, thanks for any info

The kernel stack is (in Linux) unswappable memory that persists
throughout the lifetime of a thread. It's basically how many threads
you want to be able to cram into a system, and it matters a lot for
32-bit.


-- wli
