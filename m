Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276922AbRJDQUX>; Thu, 4 Oct 2001 12:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277018AbRJDQUM>; Thu, 4 Oct 2001 12:20:12 -0400
Received: from ns.suse.de ([213.95.15.193]:30736 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S276922AbRJDQUG> convert rfc822-to-8bit;
	Thu, 4 Oct 2001 12:20:06 -0400
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <m1n137zbyo.fsf@frodo.biederman.org>
	<Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com>
	<200110041602.f94G20k06280@vindaloo.ras.ucalgary.ca>
X-Yow: I am having FUN...  I wonder if it's NET FUN or GROSS FUN?
From: Andreas Schwab <schwab@suse.de>
Date: 04 Oct 2001 18:20:32 +0200
In-Reply-To: <200110041602.f94G20k06280@vindaloo.ras.ucalgary.ca> (Richard Gooch's message of "Thu, 4 Oct 2001 10:02:00 -0600")
Message-ID: <jehetfcr73.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.107
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch <rgooch@ras.ucalgary.ca> writes:

|> Linus Torvalds writes:
|> > 
|> > On 4 Oct 2001, Eric W. Biederman wrote:
|> > >
|> > > First what user space really wants is the MAP_COPY.  Which is
|> > > MAP_PRIVATE with the guarantee that they don't see anyone else's changes.
|> > 
|> > Which is a completely idiotic idea, and which is only just another
|> > example of how absolutely and stunningly _stupid_ Hurd is.
|> 
|> Indeed. If you're updated a shared library, why not *create a new
|> file* and then rename it?!? That lets running programmes work fine,
|> and new programmes will get the new library. Also, the following
|> construct makes a lot of sense:
|> 	ld -shared -o libfred.so *.o || mv libfred.so /usr/local/lib
                                     ^^

That || should be &&, otherwise you are doing exactly the opposite of what
you want.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
