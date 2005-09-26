Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVIZOoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVIZOoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVIZOoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:44:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27887 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932138AbVIZOoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:44:44 -0400
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050926062552.GD3273@elte.hu>
References: <1127345874.19506.43.camel@dhcp153.mvista.com>
	 <433201FC.8040004@yahoo.com.au>
	 <1127355538.8950.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1127364629.8950.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050926062552.GD3273@elte.hu>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 07:44:36 -0700
Message-Id: <1127745877.28961.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 08:25 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Checks for cmpxchg in get_task_struct_rcu() . No race version.
> 
> shouldnt we actually define a global, default cmpxchg() function, based 
> on IRQ-disable - instead of open-coding one?

I was thinking it should be restructures so it just needs an atomic_inc
in this case. Considering that without cmpxchg() you must be on a UP
machine .

Daniel

