Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132495AbRARMSM>; Thu, 18 Jan 2001 07:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135255AbRARMSC>; Thu, 18 Jan 2001 07:18:02 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:24327 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132495AbRARMRr>; Thu, 18 Jan 2001 07:17:47 -0500
Date: Thu, 18 Jan 2001 06:17:37 -0600
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010118061737.A26045@cadcamlab.org>
In-Reply-To: <944s0j$9lt$1@penguin.transmeta.com> <200101180823.JAA18205@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101180823.JAA18205@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Thu, Jan 18, 2001 at 09:23:15AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rogier Wolff]
> I'd prefer an interface that says "copy this fd to that one, and
> optimize that if you can".

So do exactly that in libc.

  sendfile () {
    if (sys_sendfile() == -1)
      return (errno == EINVAL) ? do_slow_sendfile() : -1;
    return 0;
  }

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
