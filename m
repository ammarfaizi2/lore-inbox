Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317437AbSFMSiC>; Thu, 13 Jun 2002 14:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSFMSiB>; Thu, 13 Jun 2002 14:38:01 -0400
Received: from ool-4353be98.dyn.optonline.net ([67.83.190.152]:53800 "HELO
	dps7.oconnoronline.net") by vger.kernel.org with SMTP
	id <S317437AbSFMSiB>; Thu, 13 Jun 2002 14:38:01 -0400
From: "Billy O'Connor" <billy@oconnoronline.net>
To: a8603365@unet.univie.ac.at
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206131917.49235@pflug3.gphy.univie.ac.at>
	(a8603365@unet.univie.ac.at)
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
Reply-To: billy@oconnoronline.net
Message-Id: <20020613173422.B0D0D89@dps7.oconnoronline.net>
Date: Thu, 13 Jun 2002 13:34:22 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   >From billy  Thu Jun 13 12:31:23 2002
   From: Melchior FRANZ <a8603365@unet.univie.ac.at>
   Date:	Thu, 13 Jun 2002 19:17:49 +0200
   X-PGP:	http://www.unet.univie.ac.at/~a8603365/melchior.franz
   Content-Disposition: inline
   Sender: linux-kernel-owner@vger.kernel.org
   X-Mailing-List:	linux-kernel@vger.kernel.org

   * Melchior FRANZ -- Thursday 13 June 2002 18:49:
   > * rjh@world.std.com -- Thursday 13 June 2002 18:33:
   > > It resulted in an almost infinite size malloc() request.
   > 
   > No. AFAIK it is caused in the file xc/lib/font/Type1/t1font.c
							  ^^^^^^^^
   This should have been t1func.c, sorry.

t1func.c ?

This bit here, in Type1OpenScalable()?

  /* heuristic for "maximum" size of pool we'll need: */
  size = 200000 + 120 *
  (int)hypot(vals->pixel_matrix[2],
	     vals->pixel_matrix[3])
	* sizeof(short);
  if (size < 0 || NULL == (pool = (long *)xalloc(size))) {
      xfree(cid);
      DestroyFontRec(pFont);
  return AllocError;
}
