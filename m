Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSJHQN0>; Tue, 8 Oct 2002 12:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261348AbSJHQN0>; Tue, 8 Oct 2002 12:13:26 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15267 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261347AbSJHQNY>; Tue, 8 Oct 2002 12:13:24 -0400
Date: Tue, 8 Oct 2002 12:18:54 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Ofer Raz <oraz@checkpoint.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, wagnerjd@prodigy.net,
       linux-kernel@vger.kernel.org
Subject: Re: FW: 2.4.9/2.4.18 max kernel allocation size
Message-ID: <20021008121853.A23798@devserv.devel.redhat.com>
References: <1034090862.2172.1.camel@localhost.localdomain> <028101c26ee6$2c9ec010$8b705a3e@checkpoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <028101c26ee6$2c9ec010$8b705a3e@checkpoint.com>; from oraz@checkpoint.com on Tue, Oct 08, 2002 at 06:17:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 06:17:17PM +0200, Ofer Raz wrote:
> The following code was used in kernel module & called from IOCTL context in
> order to test the max allocation size possible:

I think you misunderstood. I was asking for the source
of the PROBLEM you
were having, not the test. You are doing something wrong for needing
such a huge vmalloc area, but without the source (it
is gpl code, right?) nobody can do suggestions on how to improve your code.

> 
> #define BLOCK_SIZE xxx
> 
> for (size = BLOCK_SIZE; size; size--)
> {
>     tmp = vmalloc(size * 1024 * 1024);
> 
>     if (tmp)
>     {
>         printk("Allocation of %dMB bytes succeeded!\n", size);
>         vfree(tmp);
>         break;
>     }
> }
> 
y
