Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRJ0ReB>; Sat, 27 Oct 2001 13:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273796AbRJ0Rdv>; Sat, 27 Oct 2001 13:33:51 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:58382 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S273565AbRJ0Rdk>;
	Sat, 27 Oct 2001 13:33:40 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110271726.VAA04919@ms2.inr.ac.ru>
Subject: Re: issue: deleting one IP alias deletes all
To: thockin@sun.com (Tim Hockin)
Date: Sat, 27 Oct 2001 21:26:53 +0400 (MSK DST)
Cc: david@blue-labs.org, cfriesen@nortelnetworks.com, ja@ssi.bg,
        linux-kernel@vger.kernel.org
In-Reply-To: <3BD72A8A.F4EB4188@sun.com> from "Tim Hockin" at Oct 24, 1 01:54:34 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It has done this since 2.2.x, when we first filed and fixed this bug.  I've
> pinged Alexey, and haven't heard back yet.  Maybe you'll have better
> response time.

People frequently do not understand that when creating two aliases
with completely coinciding prefixes, they must do an administrative decision:
what address they suppose to use as source address when communicating
to this network. In other words, what address is primary and what addresses
are just some unused dummies.

Well, and as soon as admin created configuration with some unused dummies,
kernel cannot promote slave to state of a citizen with full rights.

So, if you do not want an address was slave, just make it master of itself,
setting prefix length to 32.

What's about responce time... Well, I bring apologies, seeing you did not
append the patch to the note, this happened to fit to class of RTFMs
with answer which can be easily found in dejanews.

Alexey
