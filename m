Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTALUYk>; Sun, 12 Jan 2003 15:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbTALUXd>; Sun, 12 Jan 2003 15:23:33 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:37818 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267491AbTALUWi> convert rfc822-to-8bit; Sun, 12 Jan 2003 15:22:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: robw@optonline.net, David Ford <david+cert@blue-labs.org>
Subject: Re: any chance of 2.6.0-test*?
Date: Sun, 12 Jan 2003 21:31:10 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <3E21C8D5.5010301@blue-labs.org> <1042402051.3162.59.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042402051.3162.59.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301122131.10232.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But in this case, the condition was already there..  My point is that if
> you don't need a goto, you shouldn't use it.  Whenever there's an
> obvious way not to use it, don't.

You should not code to avoid a construction that's valid C.
Just use the control structure that comes natural.
Of course "if (c % 2) goto a;" is a crime, but things
like "if (!buffer) goto err_out_nomem;" are better because
the tell you why the code jumps here, it includes an implicit
comment.
if (buffer) {
	/* do stuff */
} else {
	return -ENOMEM;
}
just obscures the logic of the code.
Or look at it another way, if you dislike goto you should
crusade against conditional return as well.

	Regards
		Oliver

