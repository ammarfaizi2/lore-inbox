Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310728AbSCQM7b>; Sun, 17 Mar 2002 07:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310775AbSCQM7V>; Sun, 17 Mar 2002 07:59:21 -0500
Received: from ns.suse.de ([213.95.15.193]:34323 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310728AbSCQM7M>;
	Sun, 17 Mar 2002 07:59:12 -0500
Date: Sun, 17 Mar 2002 13:59:08 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Ian Duggan <ian@ianduggan.net>,
        Robert Love <rml@tech9.net>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
Message-ID: <20020317135908.A4006@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Ian Duggan <ian@ianduggan.net>, Robert Love <rml@tech9.net>,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16mNxQ-0000mM-00@starship> <E16mROG-00083A-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16mROG-00083A-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 03:31:24AM +0000, Alan Cox wrote:

 > Think about profiling registers, mtrrs, msrs, and so forth. For example
 > if we had thread handling MCE traps we would hit a problem. As it happens
 > MCE is an interrupt so its all nice.

 Ah, I'm glad you mentioned this. It's reminded me that my
 timer-based 'check for non-fatal machine check and log' code
 needs some work for SMP..

 Are routines called with smp_call_function() preempt safe, or
 must they have extra locking added ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
