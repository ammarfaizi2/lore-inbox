Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312453AbSDNUg2>; Sun, 14 Apr 2002 16:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312455AbSDNUg1>; Sun, 14 Apr 2002 16:36:27 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:33144 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S312453AbSDNUg0>; Sun, 14 Apr 2002 16:36:26 -0400
Date: Sun, 14 Apr 2002 21:43:45 +0100
From: Ian Molton <spyro@armlinux.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
Message-Id: <20020414214345.677aa1f5.spyro@armlinux.org>
In-Reply-To: <3CB9D940.8040303@wanadoo.fr>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.4cvs5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet Awoke this dragon, who will now respond:

> Ian Molton wrote:
> > Its a VIA based board, and it /is/ an add-on card. its a 4 port OPTi
> > based card.
> 
>  From FAQ on Alcatel site:
> 
> Q11: My modem often powers down without any reason and I have to reboot 
> to connect again.

the modem doesnt power down. all I get is an oops.

the machine is a k6-ii and is otherwise reliable (even with 100mbit
ethernet).

I've been poking about and have replaced the BUG() with a printk("about to
die!\n"), and return NULL.

I then hardened dl_reverse_done_list so it wouldnt die on receiving a NULL.

this seems to have improved things a LITTLE. I see a few 'about to die's
whizz by, and it stiffs shortly after.

does that help anyone?
