Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283660AbRLNVXH>; Fri, 14 Dec 2001 16:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283672AbRLNVW5>; Fri, 14 Dec 2001 16:22:57 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40065 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S283660AbRLNVWj>;
	Fri, 14 Dec 2001 16:22:39 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 14 Dec 2001 21:22:34 GMT
Message-Id: <UTC200112142122.VAA22189.aeb@cwi.nl>
To: sim@netnation.com, torvalds@transmeta.com
Subject: Re: [PATCH] kill(-1,sig)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course, a language lawyer will call "self" a "system process"

No, the standard very explicitly allow signalling oneself.
(And Linux also allowed that, e.g. in kill(0,sig), only until now
not in kill(-1,sig).)

>> Argh, I hate this.  I fail to see what progress a process could make
>> if it kills everything _and_ itself.

Note that kill() is just a function that sends a signal.
The signal may well be SIGWINCH or SIGSTOP or so.

Andries
