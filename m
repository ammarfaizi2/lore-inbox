Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRJDMbU>; Thu, 4 Oct 2001 08:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273893AbRJDMbA>; Thu, 4 Oct 2001 08:31:00 -0400
Received: from web11806.mail.yahoo.com ([216.136.172.160]:56587 "HELO
	web11806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273895AbRJDMat>; Thu, 4 Oct 2001 08:30:49 -0400
Message-ID: <20011004123118.49603.qmail@web11806.mail.yahoo.com>
Date: Thu, 4 Oct 2001 14:31:18 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: specific optimizations for unaccelerated framebuffers
To: linux-kernel@vger.kernel.org
In-Reply-To: <3BBC4A4E.AC6106A6@ftel.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Paul [private mail] wrote:
> You might like to do some performance measurements on
> X with a shadow framebuffer - see
> 
> http://www.xfree86.org/4.1.0/apm5.html

  This seems to still use the processor to copy the shadow buffer
 to the video memory, you will still have the PCI write stall...

> I have a machine with an SiS 630 where the video memory _is_
> main memory - the impact of the graphics processor continually
> DMAing data for display is huge.

  I am not speaking of DMA'ing at the refresh frequency (approx 70 times
 per second the complete video memory), just the modified 64Kb blocks,
 "once upon a while": if a single pixel is written twice, you will just
 see the latter written value on the screen - but who cares.
  Been able to DMA the complete video memory image around 5-10 times/second
 should be over the human eye sensitivity.
  Moreover this pixel will stay on the processor memory cache a lot
 longer, even without MTRR processors.

  Etienne.



___________________________________________________________
Do You Yahoo!? -- Un e-mail gratuit @yahoo.fr !
Yahoo! Courrier : http://fr.mail.yahoo.com
