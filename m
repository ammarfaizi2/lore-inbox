Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135997AbREJCKu>; Wed, 9 May 2001 22:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136009AbREJCKa>; Wed, 9 May 2001 22:10:30 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:45050 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135997AbREJCK2>; Wed, 9 May 2001 22:10:28 -0400
Message-ID: <3AF9F7F2.AC47F7AC@uow.edu.au>
Date: Thu, 10 May 2001 12:07:46 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] writepage method changes
In-Reply-To: <Pine.LNX.4.21.0105091940430.15959-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Well,
> 
> Here is the updated version of the patch to add the "priority" argument to
> writepage().

It appears that a -EIO return from block_write_full_page() will
result in an unlock of an unlocked page in page_launder(). Splat.

What does the new writepage() argument do, and why does
it exist?

What action should the individual writepage()s take in
response to different values of `priority'?

What is the meaning of the writepage return value for
the respective values of `priority'?

When should writepage return with the page locked,
and when not?

-
