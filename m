Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTJQJ7D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTJQJ7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:59:03 -0400
Received: from gprs147-144.eurotel.cz ([160.218.147.144]:63104 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263394AbTJQJ66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:58:58 -0400
Date: Fri, 17 Oct 2003 11:58:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Message-ID: <20031017095840.GB9173@elf.ucw.cz>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When a drive tries to read a block, if it detects errors, it retries up to
> 255 times.  If a retry succeeds then the block gets reallocated.  IF 255
> RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.

...

> They also said that a write operation has a chance of getting the bad block
> reallocated.  The conditions for reallocation on write are similar but not
> identical to the conditions for reallocate on read.  During a write
> operation if a sector is determined to be permanently bad (255 failing
> retries) then it is likely to be reallocated, unlike a read.  But I'm not
> sure if this is guaranteed or not.  We agreed that we should try it
> on my

Well, this behaviour makes sense.

"If we can't read this, leave it in place, perhaps we can read it in
future (when temperature drops below 80Celsius or something)". "If we
can't write this, bad, but we can reallocate without loosing
anything".

It looks slightly unexpected, but pretty sane to me. Anything else
would kill your data.

[BTW your subject made me delete the mail with "spam", until Hans
replied to it...]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
