Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSLOMl5>; Sun, 15 Dec 2002 07:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266489AbSLOMl5>; Sun, 15 Dec 2002 07:41:57 -0500
Received: from mrmorr.lnk.telstra.net ([139.130.12.153]:42501 "EHLO
	cheesypoof.guarana.org") by vger.kernel.org with ESMTP
	id <S266480AbSLOMlz>; Sun, 15 Dec 2002 07:41:55 -0500
Date: Sun, 15 Dec 2002 23:49:55 +1100
To: Keith Owens <kaos@ocs.com.au>
Cc: Kevin Easton <kevin@sylandro.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 st + aic7xxx (Adaptec 19160B) + VIA KT333 repeatable freeze
Message-ID: <20021215124955.GA26751@guarana.org>
References: <20021213115127.A12153@beernut.flames.org.au> <1047.1039952560@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047.1039952560@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
From: caf@guarana.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 10:42:40PM +1100, Keith Owens wrote:
> On Fri, 13 Dec 2002 11:51:27 +1100, 
> Kevin Easton <kevin@sylandro.com> wrote:
> >I'm not sure exactly where this problem fits in, but I'm getting a 
> >completely repeatable freeze (100% lockup, no response to keyboard)
> >triggered by writing to /dev/st0 (dd if=/dev/urandom of=/dev/st0 bs=512
> >count=163840 will reproduce it).
> >So... does anyone have any ideas how I should start trying to track this
> >down?
> 
> Boot with nmi_watchdog=1 (smp) or nmi_watchdog=2 (smp or up), cat
> /proc/interrupts to verify that NMI is being used.  If the problem is a
> disabled spinloop then the watchdog will trip after 5 seconds and give
> you a trace which can be run through ksymoops.  If that trace does not
> give enough data to debug the problem, apply the kdb patch[*], read
> Documentation/kdb and start digging, bt first and debug from there.

Thanks, will try that in the morning.

	- Kevin.

