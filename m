Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRHMTY1>; Mon, 13 Aug 2001 15:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbRHMTYQ>; Mon, 13 Aug 2001 15:24:16 -0400
Received: from xilofon.it.uc3m.es ([163.117.139.114]:6272 "EHLO
	xilofon.it.uc3m.es") by vger.kernel.org with ESMTP
	id <S266977AbRHMTYD>; Mon, 13 Aug 2001 15:24:03 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108131924.VAA03520@xilofon.it.uc3m.es>
Subject: Re: Is there something that can be done against this ???
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <3B7822E5.9AE35D4A@interplus.ro> "from Mircea Ciocan at Aug 13,
 2001 09:56:37 pm"
To: Mircea Ciocan <mirceac@interplus.ro>
Date: Mon, 13 Aug 2001 21:24:06 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Mircea Ciocan wrote:"
> P.S. Please tell me that I'm just being parnoid and that crap didn't
> work on your systems with a lookalike configuration.

It doesn't work. It just looks like it does to the viewer!

The "exploit" is a loadable shared library that replaces the 
getuid, geteuid, getgid and getegid functions with dummies that
always return 0. So the code in bash that looks up the
prompt and all thatgoes and  looks up roots .profile. The result is
that you get what looks like a root prompt, and your calls to 
id return 0 :-)

But it can't really change uid. Try touching a file in / !

Peter
