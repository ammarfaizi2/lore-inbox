Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971800-4553>; Sun, 26 Apr 1998 13:22:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1470 "EHLO atrey.karlin.mff.cuni.cz" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <971806-4553>; Sun, 26 Apr 1998 13:08:55 -0400
Message-ID: <19980426171746.22129@Elf.mj.gts.cz>
Date: Sun, 26 Apr 1998 17:17:46 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Alexander Kjeldaas <astor@guardian.no>
Cc: Philip Blundell <pb@nexus.co.uk>, David Woodhouse <Dave@imladris.demon.co.uk>, Meelis Roos <mroos@tartu.cyber.ee>, linux-kernel@vger.rutgers.edu
Subject: Re: faster strcpy()
References: <E0ySfV5-00058I-00@imladris.demon.co.uk> <E0ySfgI-0006zV-00@spring.nexus.co.uk> <19980426004428.17045@lucifer.guardian.no> <19980426013108.48608@lucifer.guardian.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.81
In-Reply-To: <19980426013108.48608@lucifer.guardian.no>; from Alexander Kjeldaas on Sun, Apr 26, 1998 at 01:31:08AM +0200
X-Warning: Not only using Windows can be dangerous to your mental health.
Sender: owner-linux-kernel@vger.rutgers.edu

Hi!

> > I'm not sure why Mycroft used '& ~(w)' in the above. Unless something
> > obvious escapes me, you can optimize the above down to 3
> > instructions. Both codepaths have a dependency chain of 3
> > instructions.
> > 
> > #define word_has_nullbyte(w) ((((w) - 0x01010101) ^ (w)) & 0x80808080)
> > 
> 
> Hmm.. two things obviously escaped me:
> 
> 1) The above fails horribly and detects 0x80 as a null.

It does not matter too much: you usually want 

word_has_probably_nullbyte(), since you usually want to know where the
nullbyte is and copy rest byte-by-byte.

								Pavel
-- 
I'm really pavel@atrey.karlin.mff.cuni.cz. 	   Pavel
Look at http://atrey.karlin.mff.cuni.cz/~pavel/ ;-).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
