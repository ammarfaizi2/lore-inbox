Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311530AbSCNFsI>; Thu, 14 Mar 2002 00:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311531AbSCNFr7>; Thu, 14 Mar 2002 00:47:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:3589 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311530AbSCNFro>; Thu, 14 Mar 2002 00:47:44 -0500
Date: Thu, 14 Mar 2002 01:41:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jens Axboe <axboe@suse.de>, Karsten Weiss <knweiss@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.10.10203130056210.18254-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0203140139310.4725-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Mar 2002, Andre Hedrick wrote:

> 
> Jens,
> 
> Please try again because that is not the real problem.
> All you have shown is that we disagree on the method of page walking
> between BLOCK v/s IOCTL.  This is very minor and I agreed that it is
> reasonable to map the IOCTL buffer in to BH or BIO so this is a net zero
> of negative point.
> 
> How about attempting to describe the differences between the atomic and
> what is violated by who and where.

Andre, 

Jens just described what can be violated:

"First of all, rq->buffer cannot be indexed for the entire nr_sectors
range -- it's per definition only the first segment in the request, and
can as such only be indexed within the first current_nr_sectors number of
sectors. The above can be grossly out of range..." 

Can you tell me why his is wrong ?

BTW, I just checked 2.5 and it seems to be the similar (on the non-BIO
case).


