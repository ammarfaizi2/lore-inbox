Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTEYEPK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 00:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTEYEPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 00:15:10 -0400
Received: from holomorphy.com ([66.224.33.161]:12444 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261311AbTEYEPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 00:15:09 -0400
Date: Sat, 24 May 2003 21:28:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Christian Klose <christian.klose@freenet.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Message-ID: <20030525042803.GA8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Christian Klose <christian.klose@freenet.de>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305231405.54599.christian.klose@freenet.de> <20030524142809.GZ8978@holomorphy.com> <200305250242.58269.christian.klose@freenet.de> <200305251127.40516.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305251127.40516.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 11:27:20AM +1000, Con Kolivas wrote:
> Even though you're not Marc I do agree with you. The problem is well
> described as either poor interactivity (the window wiggle test) or
> starvation in the presence of certain scheduler hogs (for whatever
> reason) since the interactivity patch from mingo. Dropping the max
> timeslice is a bandaid but destroys priority based timeslice
> scheduling. Dropping the min timeslice will bring this back, but at
> some point the timeslice will be so low that low priority cpu
> intensive tasks will spend most of their time cache trashing.

The fact that it's a "bandaid" and that it "destroys priority-based
timeslice scheduling" makes it a shenanigan. If you're having problems
solved by capping timeslices, you have someone's timeslice and/or
priority growing too large for some reason.

It'd be far better to help figure out what went wrong.


-- wli
