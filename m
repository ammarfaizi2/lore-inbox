Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTEXOPN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 10:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTEXOPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 10:15:13 -0400
Received: from holomorphy.com ([66.224.33.161]:16281 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264245AbTEXOPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 10:15:12 -0400
Date: Sat, 24 May 2003 07:28:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Klose <christian.klose@freenet.de>
Subject: Re: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Message-ID: <20030524142809.GZ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Klose <christian.klose@freenet.de>
References: <200305231405.54599.christian.klose@freenet.de> <200305231546.27463.christian.klose@freenet.de> <200305241615.49463.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305241615.49463.m.c.p@wolk-project.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 04:19:40PM +0200, Marc-Christian Petersen wrote:
> --- old/kernel/sched.c	2003-05-24 14:45:57.000000000 +0200
> +++ 2.5-mcp/kernel/sched.c	2003-05-24 16:18:42.000000000 +0200
> @@ -65,7 +65,7 @@
>   * they expire.
>   */
>  #define MIN_TIMESLICE		( 10 * HZ / 1000)
> -#define MAX_TIMESLICE		(200 * HZ / 1000)
> +#define MAX_TIMESLICE		( 10 * HZ / 1000)
>  #define CHILD_PENALTY		50
>  #define PARENT_PENALTY		100
>  #define EXIT_WEIGHT		3


This looks highly suspicious as it essentially removes dynamic timeslice
sizing. If this fixes something, then dynamic timeslice heuristics are
going wrong somewhere that should be properly described and handled, not
this kind of shenanigan.


-- wli
