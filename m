Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSEUI5z>; Tue, 21 May 2002 04:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSEUI5z>; Tue, 21 May 2002 04:57:55 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:53500 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S311025AbSEUI5y>; Tue, 21 May 2002 04:57:54 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.3075.528426.593684@wombat.chubb.wattle.id.au>
Date: Tue, 21 May 2002 18:57:39 +1000
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
        Peter Chubb <peter@chubb.wattle.id.au>, <trivial@rustcorp.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Allow aic7xx firmware to be built from BK tree. 
In-Reply-To: <Pine.LNX.4.44.0205210012470.1673-100000@chaos.physics.uiowa.edu>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kai" == Kai Germaschewski <kai-germaschewski@uiowa.edu> writes:

Kai> On Mon, 20 May 2002, Justin T. Gibbs wrote:
>> >Some people are using source control management systems which
>> >leave the managed files read-only.
>> 
>> These people shouldn't be rebuilding the firmware. 8-)

Kai> True, but some do anyway...

Or so as I do, and have a single source tree that's read-only, and
trees of links to the source tree that I build different
configurations from.

(The `touch' that   make depend   does really hurts here)

>> Only with lots of MD5 junk and other complicated rules.  I have no
>> problem with changing the name of the shipped files and using a
>> link if that will finally put this issue to rest.

Kai> Okay, I'll take care of it. I think it should be done and over
Kai> with, then.

Personally, I'd prefer a rule like:

aic7xxx_seq.h aic7xxx_reg.h: %.h : shipped_%.h
	cp $< $@

otherwise an attempt to build with CONFIG_AIC7XXX_BUILD_FIRMWARE yes
after a build with no will fail.

Peter C
