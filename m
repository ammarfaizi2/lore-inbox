Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWCQJwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWCQJwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWCQJwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:52:14 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:4993 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S964922AbWCQJwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:52:14 -0500
Date: Fri, 17 Mar 2006 10:52:08 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [ck] Re: [PATCH] -mm: Small schedule() optimization
Message-ID: <20060317095208.GA31745@rhlx01.fht-esslingen.de>
References: <20060308175450.GA28763@rhlx01.fht-esslingen.de> <200603111200.27557.kernel@kolivas.org> <20060317091347.GD13387@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317091347.GD13387@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 17, 2006 at 10:13:47AM +0100, Ingo Molnar wrote:
> 
> * Con Kolivas <kernel@kolivas.org> wrote:
> > Probably better to just
> > 	if (unlikely(in_atomic())) {
> > 		if (!current->exit_state) {
> > 
> > Ingo?
> 
> yeah. There's not much point in nesting likely/unlikely. In fact we can 
> just merge the two conditions, as per updated patch below.

ACK, thanks!

> 	Ingo

Andreas Mohr
