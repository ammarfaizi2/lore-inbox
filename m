Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271085AbRHTF63>; Mon, 20 Aug 2001 01:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271086AbRHTF6T>; Mon, 20 Aug 2001 01:58:19 -0400
Received: from kanga.comsys.ideon.se ([194.237.138.68]:43525 "EHLO
	kanga.comsys.se") by vger.kernel.org with ESMTP id <S271085AbRHTF6B>;
	Mon, 20 Aug 2001 01:58:01 -0400
Message-ID: <3B80A6C3.6050909@comsys.se>
Date: Mon, 20 Aug 2001 07:57:23 +0200
From: Lars Segerlund <lars.segerlund@comsys.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: BUG: pc_keyb.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Digital Hinote II will hang on kernals 2.4.X if ps2 mouse ( built in 
trackball is used ), not present in 2.0.38-39 kernels .... this will 
hapen after a bit of use, but is repeatable.

  Due to writing to the status register before it's ready as far as I 
can se.

  fix: change all mdelay(1) in pc_keyb.c to mdelay(2)'s .. ( mdelay(1) 
will be on the timing limit.
( /usr/src/linux/drivers/char/pc_keyb.c )

  Might also be present during high load on machines running GL on AGP 
video cards, not 100 % sure same symptoms, above seem's to fix ???? ( 
strange ).

  / best regards, Lars Segerlund.

