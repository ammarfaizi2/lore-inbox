Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129921AbQKVL5N>; Wed, 22 Nov 2000 06:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130023AbQKVL5D>; Wed, 22 Nov 2000 06:57:03 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:27386 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129091AbQKVL4y>;
	Wed, 22 Nov 2000 06:56:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A1BAC59.B0F124AF@uow.edu.au> 
In-Reply-To: <3A1BAC59.B0F124AF@uow.edu.au>  <20001121142616.L7764@sventech.com>, <20001121142616.L7764@sventech.com> <20001121095626.F3431@valinux.com> <Pine.LNX.4.30.0011211912490.22252-100000@imladris.demon.co.uk> <4627.974890115@redhat.com> 
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Oleg Drokin <green@ixcelerator.com>, linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Nov 2000 11:26:00 +0000
Message-ID: <9719.974892360@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andrewm@uow.edu.au said:
>  Nothing which sleeps for very long - mainly serial drivers which
> queue a call to tty_hangup(), which immediately queues _another_
> tq_scheduler call to do_tty_hangup (Why?  Heaven knows). 

Not so much worried about that. More about how sensitive they would be to 
something _else_ causing the eventd thread to sleep for 'multiple seconds' 
before getting round to doing what they asked.

I really don't want to have to start using multiple eventd threads before
2.5, if at all. So I don't want to add the USB hub stuff unless the other
queued tasks will be happy with that. 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
