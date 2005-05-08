Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVEHLVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVEHLVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 07:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVEHLVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 07:21:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:22026 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262845AbVEHLV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 07:21:27 -0400
Date: Sun, 8 May 2005 13:12:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: advices for a lcd driver design.
Message-ID: <20050508111216.GB18600@alpha.home.local>
References: <20050508103330.93937.qmail@web25105.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050508103330.93937.qmail@web25105.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francis,

There already are several drivers for this display, why write another one ?
One I use and know (because I wrote it :-)) is available here :
 
  http://linux.exosec.net/kernel/lcdpanel/

It works with any combination of data and control bits from a parallel port,
and can initialize early in the kernel to display a booting message. It also
supports a keypad. I know that several appliance makers who use it. It uses
/dev/lcd to send data and some ANSI codes to move the cursor, and to define
up to 8 graphics characters. It uses /dev/keypad for keypad input.

Another one exists, I don't remember its name but it used to be announced
on freshmeat. It emulates a vt52 terminal IIRC.

Hoping this helps,
Willy

On Sun, May 08, 2005 at 12:33:30PM +0200, moreau francis wrote:
> Hi,
> 
> I'm trying to write a lcd driver for a HD44780 compatible display.
> Basicaly it will be the only screen available on my linux board.
> My problem is that I don't know which desgin I should use when
> implementing the lcd's driver, because several choices are possible:
> 
> 1) implementing a dumb char device  "/dev/lcd"
> 2) implementing a console driver
> 3) implementing a tty driver
> 
> I can't find any documentation on vt that makes the choice quite
> hard but when looking at the code it may be the best choice for
> user-space. Do you think it's the good direction ?
> 
> Thanks for your advices,
> 
>       Francis.
> 
> 
> 	
> 
> 	
> 		
> __________________________________________________________________ 
> Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
> Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
