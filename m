Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267680AbTAMA56>; Sun, 12 Jan 2003 19:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267689AbTAMA56>; Sun, 12 Jan 2003 19:57:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267680AbTAMA5y>;
	Sun, 12 Jan 2003 19:57:54 -0500
From: Randy Dunlap <rddunlap@osdl.org>
Message-ID: <1850.4.64.197.173.1042420003.squirrel@www.osdl.org>
Date: Sun, 12 Jan 2003 17:06:43 -0800 (PST)
Subject: Re: any chance of 2.6.0-test*?
To: <robw@optonline.net>
In-Reply-To: <1042410059.1208.150.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
        <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
        <20030112211530.GP27709@mea-ext.zmailer.org>
        <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
        <20030112215949.GA2392@www.kroptech.com>
        <1042410059.1208.150.camel@RobsPC.RobertWilkens.com>
X-Priority: 3
Importance: Normal
Cc: <akropel1@rochester.rr.com>, <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Harder to read: The primary code path is polluted with repetative code
>> that has no bearing on its primary mission.
>
> I thought it was easier to read.  For me, I can read "ok, this condition
> happens, I fail"... Or "if this other condition happens, I release my path,
> then I fail"...

over and over, with additions each time?

> Whereas the "goto out" was very unclear.  It made me page down to figure out
> what was going on.
>
> That's the whole point.. To just browse the code.. I shouldn't have to page
> down to understand what the code right in front of me is doing.  "goto out"
> is unclear.  "retun error" is clear.  "path_release" seems like a relatively
> plain english function name and I can guess what it does without knowing
> exactly what it does.  I can also surmise that if I go beyond a certain
> point in the function that I need to path_release() the same way a
> non-kernel programmer might need to free memory allocated inside of a
> function before returning to the calling function.
So you choose to agree with your lessons that goto is bad, but
ignore the other lesson that functions shouldn't have multiple
return paths?  Or didn't have that lesson?
~Randy



