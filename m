Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbTALW1m>; Sun, 12 Jan 2003 17:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbTALW1h>; Sun, 12 Jan 2003 17:27:37 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:20141 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S267569AbTALW1e>; Sun, 12 Jan 2003 17:27:34 -0500
Message-ID: <33003.62.98.226.220.1042410973.squirrel@webmail.roma2.infn.it>
Date: Sun, 12 Jan 2003 23:36:13 +0100 (CET)
Subject: Re: any chance of 2.6.0-test*?
From: "Emiliano Gabrielli" <emiliano.gabrielli@roma2.infn.it>
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
X-MSMail-Priority: Normal
Cc: <akropel1@rochester.rr.com>, <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<quote who="Rob Wilkens">
> On Sun, 2003-01-12 at 16:59, Adam Kropelin wrote:
>> Congratulations. You've possibly increased the speed of an error path by  an
>> infintessimal amount at the expense of increasing the size of kernel image and
>> making the code harder to read and maintain. (I say "possibly" since with caching
>> effects you may have actually slowed the code down.)
>
> Hey, if the compiler does it's job right, I increased the speed of something in the
> kernel.  And, as a kernel newbie, I'm proud of that.  I also did it in under 12
> minutes (from time stamp of message received to time stamp of message sent after code
> compiled and diff'd).
>
>> Harder to read: The primary code path is polluted with repetative code that has no
>> bearing on its primary mission.
>
> I thought it was easier to read.  For me, I can read "ok, this condition happens, I
> fail"... Or "if this other condition happens, I release my path, then I fail"...
>
> Whereas the "goto out" was very unclear.  It made me page down to figure out what was
> going on.
>
> That's the whole point.. To just browse the code.. I shouldn't have to page down to
> understand what the code right in front of me is doing.  "goto out" is unclear.
> "retun error" is clear.  "path_release" seems like a relatively plain english function
> name and I can guess what it does without knowing exactly what it does.

goto out_path_release is finer to you ?!?  :)

> I can also
> surmise that if I go beyond a certain point in the function that I need to
> path_release() the same way a non-kernel programmer might need to free memory
> allocated inside of a function before returning to the calling function.
>
> It really is that simple.
>
>> Harder to maintain: Add an extra resource allocation near the top and now you have
>> to hunt out every failure case and manually update them all (with yet more duplicate
>> code) instead of just amending the cleanup code at the end of the function.
>
> It took me 12 minutes from message received to message sent to update the entire block
> of code to handle the new case.  How long do you think it would take to make a minor
> modification that would only have to do a portion of what I did?  Is it such a burden
> on the developer to make the code more readable?
>

I think you have no idea of the mole of the linux kernel and the number of daily patches
the mantainers receive ...


I'm also a beginner, and me too at the very first time hated the goto (every one have
told me they are evil !!) but after aving taken a look at the kernel and reading
LinuxDevice Driver I think that the style the linux kernel is coded is cryptic for
beginners, but it is perfect !

It is a wonderful experience to browse the linux kernel sources .. and every time I
didn't understand why a thing was done in such a way .. well I discover later (with
experience) that it was done in the best way it could ever be done !!!




-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"


