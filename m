Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317782AbSFMRbX>; Thu, 13 Jun 2002 13:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317783AbSFMRbW>; Thu, 13 Jun 2002 13:31:22 -0400
Received: from unet4-130.univie.ac.at ([131.130.233.130]:49034 "EHLO
	server.lan") by vger.kernel.org with ESMTP id <S317782AbSFMRbW>;
	Thu, 13 Jun 2002 13:31:22 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
Date: Thu, 13 Jun 2002 18:53:53 +0200
User-Agent: KMail/1.4.5
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200206131853.53896@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* rjh@world.std.com -- Thursday 13 June 2002 18:33:
> It resulted in an almost infinite size malloc() request.

No. AFAIK it is caused in the file xc/lib/font/Type1/t1font.c
by wrong RAM requirement estimation heuristics. Not too much
memory is requested but too few! And if XFree actually needs
more memory than it had originally estimated and requested, it
simply aborts.

m.

