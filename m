Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADOKW>; Thu, 4 Jan 2001 09:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADOKN>; Thu, 4 Jan 2001 09:10:13 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:43002 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129267AbRADOJ5>; Thu, 4 Jan 2001 09:09:57 -0500
Date: Thu, 4 Jan 2001 12:09:46 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: David Ford <david@linux.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-release (and a few priors) stalls
In-Reply-To: <3A54494D.C7DA0455@linux.com>
Message-ID: <Pine.LNX.4.21.0101041207570.1188-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0101041207572.1188@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, David Ford wrote:

> Recently, about test 12 I believe, I started experiencing stalls.
> I believe it has to do with VM pressure but I'm not sure.
> 
> (thank you reiserfs).

Probably an interaction between the fact that the
VM tries to write out pages but reiserfs blocking
this because of write ordering constraints...

It should become better once reiserfs has a smart
->writepage() function that will push the "right"
page to disk and allows the system to continue
faster.

The fact that swap is full may also have something
to do with it, though on my tests here the system
continued to run fine with swap space filled up.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
