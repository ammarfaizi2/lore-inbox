Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbRGYTKK>; Wed, 25 Jul 2001 15:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbRGYTKB>; Wed, 25 Jul 2001 15:10:01 -0400
Received: from tierra.stl.es ([195.235.83.3]:54855 "EHLO tierra.stl.es")
	by vger.kernel.org with ESMTP id <S267233AbRGYTJw>;
	Wed, 25 Jul 2001 15:09:52 -0400
To: linux-kernel@vger.kernel.org
Subject: Transparent proxies and binding to foreign addresses
From: Julio Sanchez Fernandez <j_sanchez@stl.es>
Date: 25 Jul 2001 21:09:13 +0200
Message-ID: <m2lmlcakrq.fsf@j-sanchez-p.stl.es>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


I have been using transparent proxies on Linux for a long time, very
possibly longer than anyone else, since I wrote a extremely crude hack
that served me well back 1995.

I mean, I am very fond of transparent proxies and I do things with
them that are extremely difficult to achieve at the kernel level.  I
also think I am pretty much aware of their problems and limitations
and, thus, resort to other techniques here and there.  But I use
proxies everytime unless I cannot afford them.

Most people think of transparent proxies as programs that just catch
connections and redirect them to other places.  That's good and it is
what Squid does, it just pretends to be the server to the client and
completes the service somehow.

But I also have scenarios where I absolutely need to pretend both to
be the server to the client and the client to the server.  That means
I need to create a socket, bind to it with a foreign address and
connect it to somewhere else.  A common use for this is the
transparent stunnel.  If the illusion is not preserved, the server
gets no idea of the origin and thus, cannot use it for authorization
or audit.  Even not so long ago, I had something like this as a part
of a pop-before-smtp setup where this working was critical.

This mechanism has worked since I originally wrote my kludge up to
2.2.x but, from what I can gather, it does not work anymore in 2.4.x.

Could someone explain to me what was the rationale for dropping this?
Is it incompatible with the deep magic in netfilter?  Was it declared
"evil" or something?  Or was it simply that no one needed it and was
lost in the rewrite until someone steps forward?

In the same line, how much effort would it entail to write the code to
put it back?  And, finally, are there philosophical problems that
would make it unacceptable for the standard kernel?

Thanks in advance,

Julio
