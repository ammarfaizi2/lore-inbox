Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292729AbSCDSsr>; Mon, 4 Mar 2002 13:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292674AbSCDSs2>; Mon, 4 Mar 2002 13:48:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:20239 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292685AbSCDSsQ> convert rfc822-to-8bit;
	Mon, 4 Mar 2002 13:48:16 -0500
Subject: Re: [PATCH] swapfile.c
From: Robert Love <rml@tech9.net>
To: Andrey Panin <pazke@orbita1.ru>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20020304112824.GA279@pazke.ipt>
In-Reply-To: <UTC200203022125.VAA144817.aeb@cwi.nl> 
	<20020304112824.GA279@pazke.ipt>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 13:48:08 -0500
Message-Id: <1015267692.15277.13.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 06:28, Andrey Panin wrote:
> On óÂÔ, íÁÒ 02, 2002 at 09:25:16 +0000, Andries.Brouwer@cwi.nl wrote:
> > In 2.5.2 swapfile.c was broken:
> > In sys_swapon() we see
> > 
> > 	swap_file = filp_open(name, O_RDWR, 0);
> > 	if (IS_ERR(swap_file))
> > 		goto bad_swap_2;
> > 
> > bad_swap_2:
> > 	...
> > 	if (swap_file)
> > 		filp_close(swap_file, NULL);
> > 
> > and this oopses the kernel.
> 
> Fixed in -dj tree.

Eww, nice spotting Andries.  If it is in the -dj tree, someone want to
push that bit to Linus?

	Robert Love

