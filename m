Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUFXOaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUFXOaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFXOaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:30:18 -0400
Received: from holomorphy.com ([207.189.100.168]:7050 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264577AbUFXOaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:30:12 -0400
Date: Thu, 24 Jun 2004 07:30:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Yusuf Goolamabbas <yusufg@outblaze.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
Message-ID: <20040624143000.GU1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Yusuf Goolamabbas <yusufg@outblaze.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20040624091548.GA8264@outblaze.com> <40DA9E89.9020801@yahoo.com.au> <20040624093440.GA8422@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624093440.GA8422@outblaze.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 05:34:40PM +0800, Yusuf Goolamabbas wrote:
> Yes, It's an SMP (Dual P3-800). Workload is a busy mailserver (get lots
> of SMTP traffic, validate users against a remote database, reject a
> truckload of connections). CONFIG_4K_STACKS=y on the 2.6.7 box, e100
> driver with NAPI turned off. No threads 
> The 2.6.7 box shows this wrt context swithes
> procs                      memory      swap          io     system cpu
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
> 19  0      0  66516  63020  78148    0    0     0  1252 6100 14653 31 69 0  0
> 22  0      0  65300  63016  78084    0    0     0     0 5989 16043 34 66 0  1
> 29  1      0  67620  63024  78212    0    0     0   992 6314 14747 31 69 0  0
> The 2.6.5 box shows this
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> 34  0      0 135928  38160 189028    0    0     0  2160 5923 22532 32 68 0  0
> 166  0      0 137752  38148 188836    0    0     0  2424 5973 21695 30 70  0  0
> 229  0      0 135060  38272 189732    0    0     0  2340 6416 23697 33 67  0  0 32  0      0 134100  38288 189852    0    0     0  3068 6342 24016 33 67 0  0

This doesn't look like very intense context switching in either case. 2.6.7
appears to be doing less context switching. I don't see a significant
difference in system time, either.

Could you please send me complete profiles?


-- wli
