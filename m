Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271017AbRIFDDT>; Wed, 5 Sep 2001 23:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271862AbRIFDDA>; Wed, 5 Sep 2001 23:03:00 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:18960 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S271017AbRIFDCx>; Wed, 5 Sep 2001 23:02:53 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <bug-binutils@gnu.org>, <linux-kernel@vger.kernel.org>,
        <gcc-bugs@gcc.gnu.org>
Cc: <jonathan.bright@onebox.com>, <aron@cs.rice.edu>
Subject: gprof, threads and forks
Date: Wed, 5 Sep 2001 20:04:00 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBEEKODKAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's rare that I cross-post to this many lists, but

1. I blew a week trying to track this little monster down, and
2. It isn't at all clear to me where the appropriate fixes and documentation
changes need to be applied.

So here goes:

If you have an executable compiled with *gcc* using the "-pg" option, it is
supposed to generate a "gmon.out" file, which you can later process with the
*binutils* utility "gprof" to produce a profile. All this magic works just
dandy for a single threaded executable, but apparently child threads and
child processes created with "fork" don't get their execution time counted.
See the following links for the gory details:

http://sources.redhat.com/ml/bug-binutils/2001-q3/msg00090.html

http://uwsg.iu.edu/hypermail/linux/kernel/0101.3/1516.html

The second link implies that it's possible to fix this at the *kernel*
level. So my question to all of you is, "what's the best way to get this
fixed?" I need to profile a multi-threaded executable and personally don't
care about the "fork" case, but I'm sure there are others who would care
about forks and not threads.
--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net  http://www.aracnet.com/~znmeb
mailto:znmeb@borasky-research.com  mailto:znmeb@aracnet.com

Stand-Up Comedy: Because Man Does Not Live By Dread Alone

