Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314544AbSEFP4J>; Mon, 6 May 2002 11:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314545AbSEFP4I>; Mon, 6 May 2002 11:56:08 -0400
Received: from mnh-1-03.mv.com ([207.22.10.35]:48392 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S314544AbSEFP4I>;
	Mon, 6 May 2002 11:56:08 -0400
Message-Id: <200205061657.LAA03052@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@suse.cz>
Cc: Guest section DW <dwguest@win.tue.nl>, Gerrit Huizenga <gh@us.ibm.com>,
        linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: UML is now self-hosting! 
In-Reply-To: Your message of "Sat, 27 Apr 2002 01:22:23 GMT."
             <20020427012223.D413@toy.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 May 2002 11:57:59 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz said:
> > 	embedding UML in things like Apache to provide a standard internal
> > 	development and execution environment
> This is little perverted, right?

Maybe :-)

> What is it good for? 

Secure mod_perl - i.e. mod_perl in an Apache that's shared with other web sites

mod_perl in any language supported by Linux

Interactive debugging of your perl on live requests inside a live Apache

See http://user-mode-linux.sourceforge.net/slides/wvu2002/wvu2002.htm

The section that's relevant here starts at 
	http://user-mode-linux.sourceforge.net/slides/wvu2002/img9.htm

There are also some wackier possibilities which I'm not sure are terribly
useful or practical, but would still be interesting to look at, such as:

Treating HTTP requests as processes, so
	# ps uax
	...
	apache    1120  0.0  0.6  4388 1536 ?        S    13:46   0:00 GET / HTTP/1.0
	...
	# kill -9 1120
or
	# nice -20 1120

Treating HTTP requests as packets and using Netfilter to manipulate them.

				Jeff

