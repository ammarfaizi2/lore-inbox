Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTJQTDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTJQTDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:03:42 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:47844 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263583AbTJQTDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:03:37 -0400
To: John Bradford <john@grabjohn.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
	<200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
	<33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
	<20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net>
	<3F8BBC08.6030901@namesys.com>
	<11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
	<20031017102436.GB10185@bitwizard.nl>
	<200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 17 Oct 2003 13:24:10 +0200
In-Reply-To: <200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk>
Message-ID: <m3zng0yun9.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> Besides, are you positive that you always got the correct data off the
> disk?  See the discussions about hashing algorithms - maybe the drive
> simply returned data that had an additional bit flipped and wasn't
> identified as bad.

One bit? No chance. The same as with ECC RAM - one bit error will always
be detected.

>  If you are having to try over 1000 times from
> userspace, the drive is in a bad way.  You shouldn't really make
> assumptions that you do usually, (that the error correction is good
> enough to ensure bad data isn't returned as good data).  If you are
> recovering data from a spreadsheet, for example, the errors could go
> unnoticed, but have catastrophic results.

Then you have to abandon using any hard drivers. Or computers at all.
Well, mirrors (with read-and-compare) are probably good enough for you,
but it has to be done at application level.

> Of course you will - it's remapped, the data isn't overwritten!  You
> may need more advanced tools,

= in practice, it's lost. Have you seen such tools?

> but you can still seek the heads to that
> part of the platter and get data from the head-amp.  Just because you
> couldn't use your simple method anymore is real reason to argue
> against fixing the problem.

against _changing_ the problem (it doesn't go away), breaking things
which are now sane.

> This may be more sensible, but not for the reasons you are suggesting,
> and not in the way that you are suggesting.

Then note that a drive can be temporarily unable to read most of the
data - due to, say, incorrect supply voltage or very high level of
electromagnetic interferences.

Would you like to trash _all_ your data in such case automatically?

> Suspect drive?  Bin it.  Do you really not value your data enough to
> do that?

Do you really not value your data enough to mark it as inaccessible?

If it comes to non-standard recovery then you should rather go for
backups.
-- 
Krzysztof Halasa, B*FH
