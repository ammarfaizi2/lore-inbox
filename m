Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWEBRBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWEBRBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWEBRBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:01:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55198 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964931AbWEBRBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:01:20 -0400
From: Andi Kleen <ak@suse.de>
To: "Christopher Friesen" <cfriesen@nortel.com>
Subject: Re: sched_clock() uses are broken
Date: Tue, 2 May 2006 18:59:18 +0200
User-Agent: KMail/1.9.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>
In-Reply-To: <44578EB9.8050402@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605021859.18948.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 18:54, Christopher Friesen wrote:
> Andi Kleen wrote:
> 
> > Agreed it's a problem, but probably a small one. At worst you'll get
> > a small scheduling hickup every half year, which should be hardly 
> > that big an issue.
> 
> Presumably this would be bad for soft-realtime embedded things.  Set-top 
> boxes, etc.

SCHED_RR/FIFO are not affected. AFAIK it's only used by the interactivity
detector in the normal scheduler. Worst case that happens is that a 
process is not detected to be interactive when it should once, which
gives it only a small penalty. On the next time slice everything will be ok again.

-Andi

