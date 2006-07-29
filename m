Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWG2KU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWG2KU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 06:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422736AbWG2KU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 06:20:56 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:445 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S1422733AbWG2KU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 06:20:56 -0400
Message-ID: <44CAD3FF.8060203@namesys.com>
Date: Fri, 28 Jul 2006 21:20:31 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com> <44CA98F9.1040900@garzik.org>
In-Reply-To: <44CA98F9.1040900@garzik.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>
> Using guilt as an argument in a technical discussion is a flashing red
> sign that says "I have no technical rebuttal"

Wow, that is really nervy.  Let's recap this all:

* reiser4 has a 2x performance advantage over the next fastest FS
(ext3), and when compression ships in a month that will double again as
well as save space.  See http://www.namesys.com/benchmarks.html, and
then ask the reiserfs-list@namesys.com whether those benchmarks are fair
representations of their experiences.  This is  in a field where a 25%
advantage is a hard won big deal.

* we described our plugin architecture in 2001.  No other FS developers
were interested, only the users were, and it was presented quite a lot.

* So we implemented plugins for ourselves, because no other FS
developers would possibly have supported us touching their code.  (I do
not say that they erred in this.)

* No one has actually made a serious case for it being genericizable
when you get to the details, it is all just handwaving.  I'd be
surprised if >10% of it was FS independent, and unsurprised if making
that 10% FS independent made the code ossified and hard to maintain.  I
do not in anyway claim that those who choose to implement Reiser4
plugins are not deeply affected by Reiser4 design choices.  Most of the
value of writing Reiser4 plugins comes from being able to reuse Reiser4
code as you choose to in the process, and if Reiser4 is not to your
taste as a whole, then nobody should impose our plugins upon you.  VFS
is a bad enough straight jacket for FS developers, we don't need even
more mandated design decisions for the FS developers to come who will be
brighter than us.  Actually, I would like to see Nate Diller implement a
competing VFS layer, I think he would do a very good job of that.

* Here we are today, and Reiser4 plugins work.  Now some say that
because we did it for Reiser4 and not for every other FS, that we should
be excluded from the kernel.  So we are supposed to re-implement it as
generic code, which will involve years of time, and then finally
something will be coded and nobody but us will use it, and then they
will tell us that because nobody but us wants to use it it cannot go
in.  If you disagree, find one ext3 developer who wants to rewrite ext3
to use plugins and change its disk format to do it. 

And you have the nerve to say that this ever was a technical
discussion?   Our code measurably works the best.  If folks want to
imitate it, go ahead, but don't blame us for making our code work
without first making those other folks's code work.  

The technical rebuttal you ask for is
http://www.namesys.com/benchmarks.html.

The only time this argument gets technical is when akpm is involved.  He
was right about what should technically be done about batch write,
which, by the way, was greeted upon completion with an if only reiser4
uses it then it should not go in response. 

We are being penalized for thinking too differently, and this whole
ping-pong between "no we don't want to do it your way" and "you did it
your way for only you, redo it for us even though we won't ever use it"
and "oh, you redid it for us but none of us want to use it, so no it is
an imposition and cannot go in" is the Kafka-esque manifestation of that. 

If only reiser4 wants to use something, then just let us do it in our
little corner without bothering anybody else.   (Though any advice from
akpm that he has time for giving us is always welcome.)  David, we
aren't asking to be in the band, we are asking to be in the jukebox.   I
think enough users want to go 2x as fast that the users would benefit
from our being in the jukebox.

Hans
