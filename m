Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271194AbTHRA27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271195AbTHRA27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:28:59 -0400
Received: from holomorphy.com ([66.224.33.161]:20452 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271194AbTHRA25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:28:57 -0400
Date: Sun, 17 Aug 2003 17:30:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Voluspa <voluspa@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
Message-ID: <20030818003005.GR32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>, Voluspa <voluspa@comhem.se>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>
References: <20030817003128.04855aed.voluspa@comhem.se> <200308171142.33131.kernel@kolivas.org> <20030817073859.51021571.voluspa@comhem.se> <200308172336.42593.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308172336.42593.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 11:36:42PM +1000, Con Kolivas wrote:
> Now for those that can't see what this is, blender and X are
> interactive tasks and getting high priority (PRI < 18) which makes
> sense. During heavy usage of blender, it is X that gets pegged for
> cpu usage (ie it is doing the work for blender), and eventually it
> gets expired onto the expired array for being naughty and stops doing
> anything till all other tasks have finished working on the active
> array. Now normally, blender should just sleep and wait till X comes
> alive again before it does anything. However here it shows clearly that 
> it is spinning madly looking for something from X, and poor X can't do 
> anything. This is the busy on wait I've described. Meanwhile, since blender 
> was seen as an interactive task (which it is), it preempts everything lower 
> priority than it till it also gets booted. 

Ugh, priority inversion.


-- wli
