Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318833AbSICRBn>; Tue, 3 Sep 2002 13:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSICRBn>; Tue, 3 Sep 2002 13:01:43 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:34556 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318833AbSICRBn>; Tue, 3 Sep 2002 13:01:43 -0400
Date: Tue, 3 Sep 2002 13:06:12 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for fs/aio.c on non-highmem systems
Message-ID: <20020903130612.F21268@redhat.com>
References: <20020830.162126.08406551.davem@redhat.com> <Pine.LNX.4.44.0208301641150.5430-100000@home.transmeta.com> <20020830.163656.76075937.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020830.163656.76075937.davem@redhat.com>; from davem@redhat.com on Fri, Aug 30, 2002 at 04:36:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 04:36:56PM -0700, David S. Miller wrote:
> Or that since the enumeration values are basically identical
> on every system that the belong in linux/kmap_types.h :-)

The main problem here is that one needs different kmap types depending 
on which context a function is called from (which is why I needed the 
enum as a parameter to the function).  Unfortunately, the amount of 
memory needed for ringbuffers can grow pretty large on a system with 
many tasks, so not kmapping them isn't an option.  Making it a #define 
certainly works quite well, but if someone has a better idea to the 
kmap mess, I'd love to see it improved.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
