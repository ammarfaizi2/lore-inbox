Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265994AbRGCUfC>; Tue, 3 Jul 2001 16:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265996AbRGCUem>; Tue, 3 Jul 2001 16:34:42 -0400
Received: from mx9.port.ru ([194.67.23.46]:43199 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S265994AbRGCUeh>;
	Tue, 3 Jul 2001 16:34:37 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: O_DIRECT! or O_DIRECT?
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.76]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15HWsV-0000lM-00@f12.port.ru>
Date: Wed, 04 Jul 2001 00:34:35 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        HI folks, sometime ago i seen on lkml a post
    from >< regarding the implementation of O_DIRECT.
     The thing about to care, is the fact, that *nobody*,
    reacted on this post. It seems to me that nobody was
    happy enough about this to tell "oh yes! at last!"

        This is interesting, because one real advantage
    of O_DIRECT are these greased weasel fast 15-20 Mb/s
    file copies, which ones makes windoze users to look
    on us as on lesser beings.

        I understand, though, that this approach scales
    bad in the terms of multithread loads, which ones are
    especially important in server environments, the place
    linux initially growed from, and that is why it wasn`t
    already implemented.

        One more problem i see here, and i think it is an
    *extremely* important one, that making open( ... ,
    BLA_BLA_BLA | O_DIRECT) is a thing some people may
    overspeculate with. I mean that implementing O_DIRECT
    in cp(1), wins the prize, but in the case of, say,
    find(1) it is definitely not a wise move. The problem
    may be determined as "poisoning" software with this
    godblessed O_DIRECT, to the state, when 70% of code
    on an average machine will use it, thus *completely*
    killing the advantages of buffered access, and
    suddenly *bang!*: the overall performance is died.

        But the worst thing, is what the process of
    poisoning is completely uncontrollable: each
    stupid doodie can think, that His shitful piece of Code,
    is Especially Important, ant that in his case O_DIRECT
    is perfectly suitable. And in the case His code is
    someway performance critical, then most likely O_DIRECT
    will really improve his Code benchmarks, and that is
    making things really awful, leading to the hell large
    crowd of pig happy dudes thinking their useless code
    is life critical, and thus dooming linux.

        Maybe i`m stupid, as these potential dudes, and
    painting things in too dark colors, but O_DIRECT,
    i think, is a dangerous thing to play with.

        That is why, i think, Linus as far as i can properly
    recall, wasn`t happy with it et al.

        Maybe i`m missing the whole point, and thus i want to
    hear what other people will tell about it.


Cheers,

  Samium Gromoff
