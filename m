Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbTJRMDS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 08:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTJRMDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 08:03:18 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:4001 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261582AbTJRMDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 08:03:17 -0400
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
	<m3zng0yun9.fsf@defiant.pm.waw.pl>
	<200310171935.h9HJZaLm002335@81-2-122-30.bradfords.org.uk>
	<m37k33igui.fsf@defiant.pm.waw.pl>
	<200310180827.h9I8Rxw8000383@81-2-122-30.bradfords.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Oct 2003 14:02:27 +0200
In-Reply-To: <200310180827.h9I8Rxw8000383@81-2-122-30.bradfords.org.uk>
Message-ID: <m3u166vjn0.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> Although, to be honest, except where performance is critical, remap on
> read is pointless.  It saves you from having to identify the bad block
> again when you write to it.  Generally, guaranteed remap on write is
> what I want.

Then I think we have an agreement.

> I did suggest that data which was recovered automatically by the drive
> on a second or subsequent read should result in a remapping of that
> block.

AFAIK this is what the drives do.

> My most important point is that writes should never fail on a good
> drive.

That's certainly what the drives do. Unless they are out of spare
sectors, of course.

Doing cat /dev/zero > /dev/hd* fixes all bad sectors on modern drive.
-- 
Krzysztof Halasa, B*FH
