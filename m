Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135588AbREBPed>; Wed, 2 May 2001 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135589AbREBPeW>; Wed, 2 May 2001 11:34:22 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:41478 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S135588AbREBPeC>; Wed, 2 May 2001 11:34:02 -0400
Message-ID: <3AF028D3.8EE24BE1@beam.demon.co.uk>
Date: Wed, 02 May 2001 16:33:40 +0100
From: Terry Barnaby <terry@beam.demon.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with map_user_kiobuf() not mapping to physical memory
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are developing a Linux driver which allows a device to read/write
directly
into a processes virtual memory space.
I have a question on using map_user_kiobuf() as we are having problems.
I was under the impression that if I used map_user_kiobuf() this would
map
the users virtual address space into locked physical memory pages so
that
I/O could be performed.
However, I note that if the user just mallocs memory and does not access
it
(No physical memory pages created) and then passes this virtual address
space
to the driver which performs a map_user_kiobuf() on it, the resulting
kiobuf
structure has all of the pagelist[] physical address entries set to the
same value
and the maplist[] entries set to 0. The devices access to this memory
now
causes system problems.
Is map_user_kiobuf() working correctly ?
Should I call some function to map the virtual address space into
physical memory
or at least pages before I call map_user_kiobuf() ?

Cheers

Terry

--
  Dr Terry Barnaby                     BEAM Ltd
  Phone: +44 1454 324512               Northavon Business Center, Dean Rd
  Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
  Email: terry@beam.demon.co.uk        Web: www.beam.demon.co.uk
  BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software Dev
                         "Tandems are twice the fun !"



