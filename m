Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129702AbQK1Jr6>; Tue, 28 Nov 2000 04:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129809AbQK1Jrs>; Tue, 28 Nov 2000 04:47:48 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:19506 "EHLO mel.alcatel.fr")
        by vger.kernel.org with ESMTP id <S129702AbQK1Jri>;
        Tue, 28 Nov 2000 04:47:38 -0500
Message-ID: <3A2377E5.6E0BCF45@vz.cit.alcatel.fr>
Date: Tue, 28 Nov 2000 10:16:22 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
Organization: xgen@linuxstart.com
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: silly [< >] and other excess
In-Reply-To: <1368.975364537@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens a écrit :

> On Mon, 27 Nov 2000 16:02:13 -0600,
> >  [Albert D. Cahalan]
> >> > Somebody else posted a reasonable hack for the [<>] problem.  His
> >> > proposal involved letting multiple values share the same markers,
> >> > something like this:
> >Me too. (:  Keith posed two objections:
> >
> >1. The >] could get word-wrapped so that it doesn't appear on the same
> >   line as the [<.  I *do not* see what makes this hard to parse
> >   reliably.
>
> People seem to have forgotten that reading an oops from the screen is
> not the only source of data.  Many oops are read from syslog which
> contains lots of different lines, most of which have no identification.
> ksymoops has to pick out oops text from a syslog and ignore all the
> non-oops lines.
>

When the oops is inside an interrupt, ther in no sync, and the only information
is on the 24 lines of the screen (not 25, because the oops ends with a "\n"
that kills one line at the top.

When you have a minor oops, you can add all information you want.
when you have a major oops that stops the machine,
implying a restart with fsck, you have only 25x80 characters.

So, 5 chars between 2 words is TOO MUCH !
why do not use only ONE special character as "~" "!" or ";"
instead of ">] [<"


>
> If the oops text is just a hex number with no identifying characters
> then it is very difficult to pick out oops text from all the other
> noise in syslog.  ksymoops already gets false positives and prints some
> non-oops text, this confuses users who think that these lines are
> related to the oops.
>
> Removing [< >] increases the already high level of ambiguity and false
> positives in oops reporting from syslog.  The presence of the marker
> characters makes the output more robust when line wrapped, without the
> markers a line wrapped trace is just a hex number.

yes, but use a marker made of only ONE character !

>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
