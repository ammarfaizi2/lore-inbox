Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbTAJLhK>; Fri, 10 Jan 2003 06:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTAJLhK>; Fri, 10 Jan 2003 06:37:10 -0500
Received: from holomorphy.com ([66.224.33.161]:31896 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261518AbTAJLhK>;
	Fri, 10 Jan 2003 06:37:10 -0500
Date: Fri, 10 Jan 2003 03:45:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: spin_locks without smp.
Message-ID: <20030110114546.GN23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 12:42:34PM +0100, Maciej Soltysiak wrote:
> while browsing through the network drivers about the etherleak issue i
> found that some drivers have:
> #ifdef CONFIG_SMP
> 	spin_lock_irqsave(...)
> #endif
> and some just:
> 	spin_lock_irqsave(...)
> or similar.
> Which version should be practiced? i thought spinlocks are irrelevant
> without SMP so we should use #ifdef to shorten the execution path.

Buggy on preempt. Remove the #ifdef


Bill
