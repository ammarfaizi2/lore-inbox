Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284509AbRLPI0u>; Sun, 16 Dec 2001 03:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284516AbRLPI0k>; Sun, 16 Dec 2001 03:26:40 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:61188 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S284509AbRLPI0a>;
	Sun, 16 Dec 2001 03:26:30 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112160826.fBG8QSj336336@saturn.cs.uml.edu>
Subject: Re: [PATCH] kill(-1,sig)
To: sim@netnation.com (Simon Kirby)
Date: Sun, 16 Dec 2001 03:26:27 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <20011215150940.A9612@netnation.com> from "Simon Kirby" at Dec 15, 2001 03:09:40 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby writes:
> On Sat, Dec 15, 2001 at 05:19:42AM -0500, Albert D. Cahalan wrote:
>> [Linus Torvalds]

>>> I do agree, I've used "kill -9 -1" myself.
>>
>> This means: EVERYTHING DIE DIE DIE!!!!
>>
>> On a Digital UNIX system, I do "/bin/kill -9 -1" often. I expect it to
>> kill the shell. This is a nice way to quickly log out and wipe out any
>> background processes that might try to save state or continue running.
>
> Exactly.
>
> And then init spawns your getty again, and you log in again, and you
> continue doing what you were doing.

No, ssh/sshd drops the connection and you step away from the computer.
If the shell doesn't die like it's supposed to, then you have to kill
it separately. The point is to log out, avoiding left-over processes.

Like this:  alias x='/bin/kill -9 -1'

> Or you could just let it not kill the process doing the killing, and
> you'd be more productive.

No, less, because you shouldn't walk away with a shell left running.
You need to kill the shell.

> My point is that I can't see a valid case where we _actually want_ -1 to
> send to itself also.
...
> Does anybody have a case where including itself is actually useful?

The above. It's time to eat or go to bed. Die! Die! All processes die!
