Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSIJXNi>; Tue, 10 Sep 2002 19:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSIJXNi>; Tue, 10 Sep 2002 19:13:38 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:63756 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318213AbSIJXNh>; Tue, 10 Sep 2002 19:13:37 -0400
Message-ID: <3D7E7D5F.F37D2D49@linux-m68k.org>
Date: Wed, 11 Sep 2002 01:16:47 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: linux kernel conf 0.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/lkc-0.5.tar.gz you can find the
latest version of the new config system. Besides various small bug
fixes, it includes the following changes:
- Improved mouse interface of qconf
- qconf isn't build if QT isn't available
- "if" ... "endif" block added
- update to 2.5.35

With the exception of the X interface I'm not planning any big visible
changes anymore, so slowly I'd like to know any reason, why this config
system shouldn't go into 2.5.x. The old arguments against cml2 don't
really work anymore, so you have to come up with something new. :-)
The only argument I know of is that various people on kbuild mailing
list are afraid, that Linus wouldn't accept such a big change. I think
hardly anyone cares how the config backend is implemented, so the only
really visible change is the new config format, but here only the format
is new, the information is still the same (if anyone cares about the
subtle differences, I can explain them separately). Making a clear cut
now is really the easiest solution. Changing parsers and syntax
separately would be more painful, as we risks constants subtle behaviour
changes and bugs during this period, by doing a single switch we can
quickly get over it.
Otherwise the little feedback I got was mostly positive, so if anything
thinks the old config system is in any way better, I'd really like to
know about it now (and if anyone wants to keep the old system, (s)he
just volunteered to fix all the subtle differences between the three
different parsers). So unless I hear objections rather soon, it's up to
Linus.

bye, Roman
