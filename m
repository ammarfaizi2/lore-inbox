Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRIMULM>; Thu, 13 Sep 2001 16:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272020AbRIMULC>; Thu, 13 Sep 2001 16:11:02 -0400
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:40646 "HELO
	rhlx01.fht-esslingen.de") by vger.kernel.org with SMTP
	id <S272056AbRIMUKs> convert rfc822-to-8bit; Thu, 13 Sep 2001 16:10:48 -0400
Subject: RE: FW: OT: Integrating Directory Services for Linux
From: Nils Philippsen <nils@wombat.dialup.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <001c01c139ee$bef37330$1f0201c0@w2k001>
In-Reply-To: <001c01c139ee$bef37330$1f0201c0@w2k001>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13.99 (Preview Release)
Date: 13 Sep 2001 22:10:04 +0200
Message-Id: <1000411805.19631.29.camel@wombat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-10 at 13:50, Ron Van Dam wrote:
[snip]
> >>PAM is the standardized and agreed-upon method for divorcing
> >>authentication from the system.  It's been like that for quite some time
> >>now.  What if this discussion was about some Linux GUI apps not being
> >>compatible with X?  The boat's been sailing for quite some time, either
> >>hop on or build your own, I say, or swim (sink?).
> <snip>
> >>What's wrong with the name service switch stuff?  and more importantly,
> >>PAM?
> 
> In my opinion PAM is a hack, and it breaks a compatibly with a lot of stuff

Can you elaborate on that? IMO what PAM does is the only sensible thing
to do: abstraction of the authentication procedure. You cannot have
different authentication schemata (passwords (encrypted with Unix
crypt(), MD5, algorithm-of-the-month), smart-cards, biometrical
methods), multiple independently developed programs and stay sane
without such a thing as PAM in place. One can discuss _how_ PAM does
what it does, but _what_ it does only makes sense.

> out there. I really don't care what technology is used to get the job done.
> But as I said in a earlier post I don't see how DS can become reality unless
> there is a standard supported by everyone.

That won't happen. What you propose induces a single point of failure
where it isn't necessary. Personally I like that if something screws up
my nameserver configuration that I still can login -- this is one point
why I abhor anything remotely resembling to a registry, a centralized
configuration database (or directory if you wish). Think of what would
happen if some bits flipped in your directory and all of a sudden root
can't write to disk anymore (ok, I'm painting black here).

> What if some less then enthusiastic has semi-mangled a /etc file. Can you
> guarantee that the  script will correctly parse and modify it? Scripting
> works fine if the machines are completely uniform, but I bet you there are a
> lot of sysadmins that would be weary of perform a large scale change on
> /etc/*.conf files.

In that scale, any configuration files rolled out to my machines would
be generated from scratch, i.e. with templates or a similar technique.

> I know I am going to get some dirty looks about this, but also consider the
> scenerio that a larger company wants to move off of Windows to Linux for the
> desktop. To start off most of your desktop support technicians will NOT be
> capable of writing scripts to apply changes. With a DS system in place you
> can create admin tools that dumb down the configuration. I know some people
> will consider this a week argument,but its true.

You can even create "admin tools that dumb down the configuration" with
the current arcane method of plain ASCII configuration files. Not that
I'd like admins who need dumbed down configuration to administer my
machines. If you want working machines, you need skilled personnel to
operate them -- that's my opinion. If you have a network of NT machines,
you know a decent admin by his ability to script his tasks. Switching
from scripting on Windows to Unix/Linux shouldn't be hard, rather the
opposite.

> I believe that in order for Linux to reach the desktop, there has to be a
> method to manage them easier than the current available tools. I think
> DS is the best approach.

In order for Linux to reach the desktop, there is a lot to be done, but
I suspect it more in the areas of user interfaces (interoperability
between KDE and GNOME for instance, decent help systems),
interoperability with MS Office, games. The admin tools that exist now
are mostly sufficient when it comes to end users.

Nils
-- 
 Nils Philippsen / Berliner Straﬂe 39 / D-71229 Leonberg //
+49.7152.209647
nils@wombat.dialup.fht-esslingen.de / nils@redhat.de /
nils@fht-esslingen.de
        Ever noticed that common sense isn't really all that common?

