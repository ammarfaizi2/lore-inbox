Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTFDCOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 22:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFDCOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 22:14:41 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:30735 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262593AbTFDCOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 22:14:40 -0400
Date: Tue, 3 Jun 2003 19:25:12 -0700
From: jw schultz <jw@pegasys.ws>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.70_btime-fix_A0
Message-ID: <20030604022512.GI12649@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	lkml <linux-kernel@vger.kernel.org>
References: <1054681259.32091.783.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054681259.32091.783.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 04:00:59PM -0700, john stultz wrote:
> All,
> 
> 	Since jiffies didn't necessarily start incrementing at a second
> boundary, jiffies/HZ doesn't increment at the same moment as
> xtime.tv_sec. This causes one second wobbles in the calculation of btime
> (xtime.tv_sec - jiffies/HZ).  
> 
> This fix increases the precision of the calculation so the usec
> component of xtime is used as well. Additionally it fixes some of the
> non-atomic reading of time values. 
> 
> 
> This is a fix for bugme bug #764.
> http://bugme.osdl.org/show_bug.cgi?id=764
> 
> 
> Let me know if you have any comments

Might it not be cheaper to start jiffies at the 1 second
boundary or with a value that simulates that?

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
