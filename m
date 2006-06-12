Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752159AbWFLSrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbWFLSrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbWFLSrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:47:04 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:10411 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1752157AbWFLSrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:47:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=p0VrOK8RD5eNowKsjPWG3CgD99kmGVEsj044LkO6CVK/HK6mVMFSCX6Qu4Ul+zj/;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <01bb01c68e50$93753de0$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Gerhard Mack" <gmack@innerfire.net>, "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: "Bernd Petrovitsch" <bernd@firmix.at>, <davids@webmaster.com>,
       <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com><193701c68d16$54cac690$0225a8c0@Wednesday><1150100286.26402.13.camel@tara.firmix.at><00de01c68df9$7d2b2330$0225a8c0@Wednesday><Pine.LNX.4.64.0606121331090.16348@mtl.rackplans.net> <m38xo244wz.fsf@defiant.localdomain>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Date: Mon, 12 Jun 2006 11:46:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120b56ff735b21b1800e84a44462615dc25a2d4e88014a4647c350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.167.175
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Krzysztof Halasa" <khc@pm.waw.pl>

> Gerhard Mack <gmack@innerfire.net> writes:
> 
>> Look at it from a mail admin's perspective.  The bounces are now going 
>> nowhere instead of some poor user's mailbox.  You have just cut the damage 
>> in half.
> 
> If people doing SPF configured their servers to reject obviously
> bad messages before the SMTP transaction is completed (rather than
> generating a bounce later) it would IMHO do much more good.

Krzysztof, the point here is that experience with active spam
filtering indicates that there is no such thing as "obviously bad
messages" that will not catch some good messages in its broad
brush. It will also let some not quite so obvious bad messages
through. SPF has ONE "fail" mode which is relatively good. Aside
from that it is as close to worthless for filtering spam as
anything else. It's a hint and nothing more.

SPF as a part of a fully configured anti-spam system has some use.
SPF used ALONE is as bad as SORBS used alone. You will suffer a
false alarm rate sufficient that most people would consider it quite
unacceptable.

Filtering on the basis of SPF records is not a technique that would
prove acceptable or practical for LKML. Nor will it materially stop
spam from determined spammers. The SPF record vouches for the email.
Who vouches for the SPF record?

Besides, I rather suspect everybody on this list is in a position
to and capable of setting up a decent spam filter for themselves.
I'm certainly not at the level of expertise of many or most of the
people active on this list. Yet I have a spam filter setup that has
not let a single spam leak through on this list in the last month.
Nor has it misfired once in the last month. I am not particularly
aggressive maintaining my rule sets. I don't touch them unless
something new annoys me or a spam escapes detection. About two
months ago the LKML and other similar open list spam leakage finally
"reached me." I looked at prior attempts to filter LKML. Noted what
worked and what didn't. And I ended up hitting a simple strategy.
(Unfortunately it is awkward with SpamAssassin. But it works.) I
basically make the low Bayes scores score even lower or even negative
for these "problem lists". I make the high Bayes scores score even
higher for these "problem lists". After that and with my prior Bayes
training spam from this list and others like it has simply gone away.

I used my head for something other than a hat rack for 15 minutes
to solve the problem the right way. I found a suitable wrench to
repair the email plumbing rather than beating it with a hammer or
prying at it with a screwdriver. SPF seems to be at best a MUNGED
hex key.

{^_^}   Joanne
