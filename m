Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286401AbRLJVhn>; Mon, 10 Dec 2001 16:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286394AbRLJVgD>; Mon, 10 Dec 2001 16:36:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58637 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286397AbRLJVfd>; Mon, 10 Dec 2001 16:35:33 -0500
Subject: Re: Linux/Pro  -- clusters
To: Andries.Brouwer@cwi.nl
Date: Mon, 10 Dec 2001 21:44:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, viro@math.psu.edu
In-Reply-To: <UTC200112102131.VAA281019.aeb@cwi.nl> from "Andries.Brouwer@cwi.nl" at Dec 10, 2001 09:31:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DYEH-0003a9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Object lifetime becomes explicit, and we don't have to
>     worry about re-use races since a new instance of that major,minor
>     will have a different object attached to the one in use that is
>     about to be refcounted into oblivion by currently active requests
> 
> As described, my setup certainly has no re-use races, since
> I do not use refcounts as a way to terminate the lifespan of
> a kdev_t. So, are you saying that you prefer my version?
> I have problems reading your replies.

I have problems understanding your argument. Basically you seem to be saying
"void *  is cool" (aka kdev_t is basically an opaque magic).  I don't see
what it gains you over "struct block_device *".

Alan
