Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbTALWaQ>; Sun, 12 Jan 2003 17:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbTALWaQ>; Sun, 12 Jan 2003 17:30:16 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:60573 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267574AbTALW3h> convert rfc822-to-8bit; Sun, 12 Jan 2003 17:29:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: robw@optonline.net
Subject: Re: any chance of 2.6.0-test*?
Date: Sun, 12 Jan 2003 23:38:20 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <20030112215949.GA2392@www.kroptech.com> <1042410059.1208.150.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042410059.1208.150.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301122338.20038.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. Januar 2003 23:21 schrieb Rob Wilkens:
> On Sun, 2003-01-12 at 16:59, Adam Kropelin wrote:
> > Congratulations. You've possibly increased the speed of an error path by
> > an infintessimal amount at the expense of increasing the size of kernel
> > image and making the code harder to read and maintain. (I say "possibly"
> > since with caching effects you may have actually slowed the code down.)
>
> Hey, if the compiler does it's job right, I increased the speed of
> something in the kernel.  And, as a kernel newbie, I'm proud of that.  I
> also did it in under 12 minutes (from time stamp of message received to
> time stamp of message sent after code compiled and diff'd).

Nope you didn't.
Any compiler that can move outline code like
if (con) {
	cleanup()
	return err;
}
can easily simplify
if (con)
	goto err_out;
into a single branch. Still you have enlarged the kernel a bit.
With the same number of jumps, as a rule of thumb, the smaller
code is faster.

	Regards
		Oliver

