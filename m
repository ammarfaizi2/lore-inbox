Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135598AbREBPv4>; Wed, 2 May 2001 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbREBPvr>; Wed, 2 May 2001 11:51:47 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:8724 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S135598AbREBPv3>; Wed, 2 May 2001 11:51:29 -0400
Date: Wed, 2 May 2001 16:34:42 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Terry Barnaby <terry@beam.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with map_user_kiobuf() not mapping to physical memory
In-Reply-To: <3AF028D3.8EE24BE1@beam.demon.co.uk>
Message-ID: <Pine.LNX.3.96.1010502163250.30769A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Terry Barnaby wrote:
> However, I note that if the user just mallocs memory and does not access
> it
> (No physical memory pages created) and then passes this virtual address
> space
> to the driver which performs a map_user_kiobuf() on it, the resulting
> kiobuf
> structure has all of the pagelist[] physical address entries set to the
> same value
> and the maplist[] entries set to 0. The devices access to this memory
> now
> causes system problems.
> Is map_user_kiobuf() working correctly ?
> Should I call some function to map the virtual address space into
> physical memory
> or at least pages before I call map_user_kiobuf() ?

No.. but you might just have done something wrong.

See the example in arch/cris/drivers/examples/kiobuftest.c

(that example does not deallocate the vectors properly IIRC, but the
actual kiobuf mapping sequence should work)

/BW

