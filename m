Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTECWvE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 18:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTECWvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 18:51:04 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:28944 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263459AbTECWu7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 18:50:59 -0400
Date: Sat, 03 May 2003 17:03:11 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Aic7xxx and Aic79xx Driver Updates
Message-ID: <1430760000.1052002991@aslan.scsiguy.com>
In-Reply-To: <Pine.LNX.4.44.0305021117270.1667-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305021117270.1667-100000@home.transmeta.com>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2 May 2003, James Bottomley wrote:
>> 
>> I'm not asking for any changes to the way you do 2.4, just for 2.5 where
>> we have no vendor versions to support and there should only be a single
>> tree.
> 
> The way the backwards-compatibility is _meant_ to work is that a driver 
> can just do this:
> 
> 	#ifndef IRQ_RETVAL
> 	  typedef void irqreturn_t;
> 	  #define IRQ_NONE
> 	  #define IRQ_HANDLED
> 	  #define IRQ_RETVAL(x)
> 	#endif

I switched the drivers to using this yesterday.

	#ifndef IRQ_RETVAL
	  typedef void irqreturn_t;
	  #define IRQ_RETVAL(x)
	#endif

Updated BK send and tar files are here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

--
Justin

