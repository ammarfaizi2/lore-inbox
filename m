Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132952AbRDEOqt>; Thu, 5 Apr 2001 10:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132951AbRDEOqk>; Thu, 5 Apr 2001 10:46:40 -0400
Received: from ns.suse.de ([213.95.15.193]:34571 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132908AbRDEOq1>;
	Thu, 5 Apr 2001 10:46:27 -0400
To: Joseph Carter <knghtbrd@debian.org>
Cc: Bart Trojanowski <bart@jukie.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER>
	<Pine.LNX.4.30.0104050901500.13496-100000@localhost>
	<20010405072628.C22001@debian.org>
X-Yow: I want another RE-WRITE on my CAESAR SALAD!!
From: Andreas Schwab <schwab@suse.de>
Date: 05 Apr 2001 16:45:44 +0200
In-Reply-To: <20010405072628.C22001@debian.org>
Message-ID: <jevgojiew7.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.101
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Carter <knghtbrd@debian.org> writes:

|> On Thu, Apr 05, 2001 at 09:06:20AM -0400, Bart Trojanowski wrote:
|> > So you ask: "why not just use a { ... } to define a macro".  I don't
|> > remember the case for this but I know it's there.  It has to do with a
|> > complicated if/else structure where a simple {} breaks.
|> 
|> This doesn't follow in my mind.  I can't think of a case where a { ... }
|> would fail, but a do { ... } while (0) would succeed.  The former would
|> also save a few keystrokes.

Try this and watch your compiler complaining:

#define foo() { }
#define bar() do { } while (0)
void mumble ()
{
        if (1) foo(); else bar();
        if (2) bar(); else foo();
}

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
