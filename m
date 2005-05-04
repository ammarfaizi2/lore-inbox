Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVEDTQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVEDTQR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVEDTQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:16:17 -0400
Received: from nevyn.them.org ([66.93.172.17]:35205 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261394AbVEDTQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:16:06 -0400
Date: Wed, 4 May 2005 15:16:04 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
Message-ID: <20050504191604.GA29730@nevyn.them.org>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Olivier Croquette <ocroquette@free.fr>,
	LKML <linux-kernel@vger.kernel.org>
References: <4279084C.9030908@free.fr> <Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 02:16:24PM -0400, Richard B. Johnson wrote:
> The kernel doesn't do SIGSTOP or SIGCONT. Within init, there is
> a SIGSTOP and SIGCONT handler. These can be inherited by others
> unless changed, perhaps by a 'C' runtime library. Basically,
> the SIGSTOP handler executes pause() until the SIGCONT signal
> is received.
> 
> Any delay in stopping is the time necessary for the signal to
> be delivered. It is possible that the section of code that
> contains the STOP/CONT handler was paged out and needs to be
> paged in before the signal can be delivered.
> 
> You might quicken this up by installing your own handler for
> SIGSTOP and SIGCONT....

I don't know what RTOSes you've been working with recently, but none of
the above is true for Linux.  I don't think it ever has been.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
