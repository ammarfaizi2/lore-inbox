Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279842AbRJ3Dwv>; Mon, 29 Oct 2001 22:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279844AbRJ3Dwl>; Mon, 29 Oct 2001 22:52:41 -0500
Received: from pacujo.datastreet.com ([208.179.44.95]:2578 "EHLO
	lumo.pacujo.nu") by vger.kernel.org with ESMTP id <S279842AbRJ3Dwb>;
	Mon, 29 Oct 2001 22:52:31 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15yJtV-00044i-00@the-village.bc.nu> (message from Alan Cox on
	Mon, 29 Oct 2001 21:24:29 +0000 (GMT))
Subject: Re: Need blocking /dev/null
In-Reply-To: <E15yJtV-00044i-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20011030035221.6E5611FE7D@varmo.pacujo.nu>
Date: Mon, 29 Oct 2001 19:52:21 -0800 (PST)
From: marko@pacujo.nu (Marko Rauhamaa)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I noticed that I need a pseudodevice that opens normally but blocks all
> > reads (and writes). The only way out would be through a signal. Neither
> 
> Try using a pipe

You're right. This is what I wanted to do:

   while true
   do
       ssh -R a:b:c host
       sleep 10
   done </dev/never >/dev/null

But I could do it like this:

   while true
   do
       sleep 100000
   done |
   while true
   do
       ssh -R a:b:c host
       sleep 10
   done >/dev/null


Thank you.


Marko

PS Are /dev/null and /dev/zero also redundant?

-- 
Marko Rauhamaa    mailto:marko@pacujo.nu     http://www.pacujo.nu/marko/
