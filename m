Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbUDTOE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUDTOE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUDTOE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:04:29 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:8413 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S262962AbUDTOE1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:04:27 -0400
From: Axel =?iso-8859-15?q?Wei=DF?= <aweiss@informatik.hu-berlin.de>
Organization: =?iso-8859-15?q?Humboldt-Universit=E4t=20zu?= Berlin
To: "John Que" <qwejohn@hotmail.com>
Subject: Re: NIC inerrupt
Date: Tue, 20 Apr 2004 16:04:17 +0200
User-Agent: KMail/1.5.1
References: <BAY14-F34eqdGSyMp690005e9f6@hotmail.com>
In-Reply-To: <BAY14-F34eqdGSyMp690005e9f6@hotmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404201604.17238.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 19. April 2004 14:46 schrieb John Que:
> Hello,
>
> I want to count the number of times I reach an NIC receive
> interrupt.
>
> I added a global static variable of type int , and initialized
> it to 0 ; each time I am in the rx_interrupt of the card I incerement
> it by one;
> I got large , non sensible numbers after one or two seconds;
>
> So  for debug I added printk each time I increment it in rx_interrupt.
>
> What I see is that there are  unreasonable jumps in the number
>
> for instance , it inceremnts sequntially from 1 to 80,then jums to 4500,
> increments a little sequentially to 4580, and the jums again to
> 11000 ;
>
> Is it got to do with it that this is in interrupt?
> Any idea what it can be ?
>
>
> (I also tried to declare it as static in the rx_interrupt method
> and the same happened)

Probably you didn't declare your count variable 'volatile'?

Axel

-- 
Humboldt-Universität zu Berlin
Institut für Informatik
Signalverarbeitung und Mustererkennung
Dipl.-Inf. Axel Weiß
Rudower Chaussee 25
12489 Berlin-Adlershof
+49-30-2093-3050

