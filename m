Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267164AbSKMKmZ>; Wed, 13 Nov 2002 05:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSKMKmZ>; Wed, 13 Nov 2002 05:42:25 -0500
Received: from ns.suse.de ([213.95.15.193]:28681 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267164AbSKMKmY>;
	Wed, 13 Nov 2002 05:42:24 -0500
To: Jan Hudec <bulb@ucw.cz>
Cc: Andreas Gruenbacher <agruen@suse.de>, Adam Voigt <adam@cryptocomm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
	<200211121657.20437.agruen@suse.de> <20021113095133.GC21446@vagabond>
X-Yow: If I pull this SWITCH I'll be RITA HAYWORTH!!  Or a SCIENTOLOGIST!
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 13 Nov 2002 11:49:13 +0100
In-Reply-To: <20021113095133.GC21446@vagabond> (Jan Hudec's message of "Wed,
 13 Nov 2002 10:51:34 +0100")
Message-ID: <jefzu5eod2.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec <bulb@ucw.cz> writes:

|> On Tue, Nov 12, 2002 at 04:57:20PM +0100, Andreas Gruenbacher wrote:
|> > On Tuesday 12 November 2002 16:38, Adam Voigt wrote:
|> > > I have a directory with 39,000 files in it, and I'm trying to use the cp
|> > > command to copy them into another directory, and neither the cp or the
|> > > mv command will work, they both same "argument list too long" when I
|> > > use:
|> > >
|> > > cp -f * /usr/local/www/images
|> > >
|> > > or
|> > >
|> > > mv -f * /usr/local/www/images
|> > 
|> > Note that this is not a kernel related question.

Actually it is, because it's a kernel limit.  Userspace does not have
this problem in general.

|> > expanded into a list of all entries in the current directory, which results 
|> > in a command line longer than allowed. Try this instead:
|> > 
|> > find -maxdepth 1 -print0 | \
|> > 	xargs -0 --replace=% cp -f % /usr/local/www/images
|> 
|> Find has an -exec operator in the first place, so this is a little:
|> 
|> find -maxdepth 1 -exec cp -f '{}' /usr/local/www/images ';'

Or even using the shell:

for f in *; do cp -f "$f" /usr/local/www/image; done

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
