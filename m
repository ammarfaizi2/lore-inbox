Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbRCEVQz>; Mon, 5 Mar 2001 16:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbRCEVQp>; Mon, 5 Mar 2001 16:16:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:47037 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130664AbRCEVQb>;
	Mon, 5 Mar 2001 16:16:31 -0500
Date: Mon, 5 Mar 2001 22:15:44 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103052115.WAA74921.aeb@vlet.cwi.nl>
To: P.Flinders@ftel.co.uk, pozsy@sch.bme.hu
Subject: Re: binfmt_script and ^M
Cc: bug-bash@gnu.org, jeffm@iglou.com, kodis@mail630.gsfc.nasa.gov,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br,
        root@chaos.analogic.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And what does POSIX say about "#!/bin/sh\r" ?

Nothing at all. The #! construction is not part of any standard
right now. The implementation is messy - different operating systems
do vaguely similar things, but all details differ.
Linux can do whatever it wants.
Of course it helps portability if we stay close to what other OSs do.

There is some discussion at
  http://www.cwi.nl/~aeb/std/hashexclam-1.html
Additions and corrections welcome.

In this particular case I have no strong opinion,
but would not object to removing the '\r'.

The standard defines whitespace in the POSIX locale, as one or more
<blank>s (<space>s and <tab>s), <newline>s, <carriage-return>s,
<form-feed>s, and <vertical-tab>s.
Some systems strip the #! line for trailing whitespace, some don't.

Andries
