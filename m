Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSKIEdp>; Fri, 8 Nov 2002 23:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbSKIEdo>; Fri, 8 Nov 2002 23:33:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62476 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261857AbSKIEdm>; Fri, 8 Nov 2002 23:33:42 -0500
Date: Fri, 8 Nov 2002 20:40:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Dipankar Sarma <dipankar@gamebox.net>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] Re: UP went into unexpected trashing 
In-Reply-To: <20021109041542.054AF2C0DF@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211082038580.1609-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Nov 2002, Rusty Russell wrote:
> - * Returns the bit-number of the first zero bit, not the number of the byte
> - * containing a bit.
> + * Returns the bit-number of the first zero bit (not the number of the byte
> + * containing the bit) or a value >= size if none found.

Ok.

However, what was the original codepath that doesn't follow this and was 
the cause of the headache (ie the "unexpected trashing"?) Let's fix that 
user of the functions too, not just the documentation..

		Linus

