Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135634AbRDYMDd>; Wed, 25 Apr 2001 08:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135719AbRDYMDX>; Wed, 25 Apr 2001 08:03:23 -0400
Received: from corp1.cbn.net.id ([202.158.3.24]:61190 "HELO corp1.cbn.net.id")
	by vger.kernel.org with SMTP id <S135634AbRDYMDS>;
	Wed, 25 Apr 2001 08:03:18 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: root@chaos.analogic.com (Richard B. Johnson),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
From: imel96@trustix.co.id
Subject: Re: [PATCH] Single user linux
Date: Wed, 25 Apr 2001 12:04:26 GMT
X-Mailer: CBN WebMail v0.0.1
X-Mailer-OriginatingIP: 202.150.229.23, 152.118.24.5
Message-Id: <20010425120319Z135634-682+3531@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first, i think i owe you guys apology for didn't make myself
clear, which is going harder if you irritated.
even my subject went wrong, as the patch isn't really about
single user (which confuse some people).

for those who didn't read that patch, i #define capable(),
suser(), and fsuser() to 1. the implication is all users
will have root capabilities.

then i tried to bring up the single user thing to hear
opinions (not flames). and by that, i actually didn't mean
to have users share the same uid/gid 0. i know somebody
will need to differentiate user.

so when everybody suggested playing with login, getty, etc.
i know you have got the wrong idea. if i wanted to play
on user space, i'd rather use capset() to set all users
capability to "all cap". that's the perfect equivalent.

so the user space solution (capset()) works, but then came
the idea to optimize away. that's what blow everybody up.
don't get me wrong, i always agree with rik farrow when he
wrote in ;login: that we should build software with security
in mind.

but i also hate bloat. lets not go to arm devices, how about
a notebook. it's a personal thing, naturally to people who
doesn't know about computer, personal doesn't go with multi
user. by that i mean user with different capabilities, not
different persons.

i haven't catch up with all my mails, but my response to
some:
- linux is stable not only because security.
- linux was designed for multi-user, dos f.eks. is designed
  for personal use, so does epoc, palmos, mac, etc.
- i even use plan9 with kfs restrictions disabled sometimes,
  cause i don't have cpu server, auth server, etc.
- with that patch, people will still have authentication.
  so ssh for example, will still prevent illegal access, if
  you had an exploit you're screwed up anyway.
  sure httpd will give permission to everybody to browse
  a computer, but i don't think a notebook need to run it.

so i guess i deserve opinions instead of flames. the
approach is from personal use, not the usual server use.
if you think a server setup is best for all use just say so,
i'm listening.


> It would be far more interesting to rip out all trace of 
security.
> That would include the kernel memory access checking, 
parts of the
> task struct, filesystem and VFS code, and surely much 
more.

i did say it clearly that i have other changes which i know
won't be a clean patch (too many #ifdefs). f.eks. on my
computer i didn't even compile user.c in, i don't have
user_struct. filesystem and vfs code are affected by that
patch already. memory access is important of course.

> Then you can try to show a measurable performance 
difference.

nah, performance was never my consideration. i do save about
3kb from my zImage, but i'm not interested.


imel (writing from a
webmail)

----------------------------------------------------
This email was sent using http://webmail.cbn.net.id/


