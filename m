Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135321AbRDZLaV>; Thu, 26 Apr 2001 07:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135328AbRDZLaL>; Thu, 26 Apr 2001 07:30:11 -0400
Received: from corp2.cbn.net.id ([202.158.3.25]:5907 "HELO corp2.cbn.net.id")
	by vger.kernel.org with SMTP id <S135321AbRDZL37>;
	Thu, 26 Apr 2001 07:29:59 -0400
Date: Thu, 26 Apr 2001 18:31:54 +0700 (JAVT)
From: <imel96@trustix.co.id>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
In-Reply-To: <3AE7EE6F.28446A2C@idb.hist.no>
Message-ID: <Pine.LNX.4.33.0104261730510.1677-100000@tessy.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Helge Hafting wrote:
> The linux kernel ought to be flexible, so most people can use
> it as-is.  It can be used as-is for your purpose, and
> it have been shown that this offer more security _without_
> inconvenience.  Your patch however removes multi-user security
> for the many who needs it - that's why it never will get accepted.
> Feel free to run your own patched kernels - but your
> patch will never make it here.

i don't understand, that patch is configurable with 'n' as
default, marked "dangerous". so somebody who turned on that
option must be know what he's doing, doesn't understand english,
or has a broken monitor.


> If you really want optimization, remove all security instead of
> merely killing a few basic tests.

those tests responsible for almost all EACCESS & EPERM.


> The notebook user might not care or understand about
> multi-user security, but it is still useful.  The user
> have several daemons running that he don't know about,
> they were installed by the distribution.
> The security system can protect files from buggy
> or cracked daemons.

must be a devil cursed distro, distributing "single-user"
kernel with live daemons. a division of redmon?

> And protecting the
> configuration (and essential stuff like the user's GUI) from
> being deleted by user accident is still a good thing.
>
> The user who don't need password security can still have a "safe"
> SUID admin program for necessary tasks like changing the
> dialup phone number even though it resides in a protected
> file.  So you definitely want the protection system, even
> in a "personal" appliance running linux.  Because it
> protects against stupid mistakes like experimenting
> with editing files in the /etc directory on the notebook with
> a word processor.  Users don't understand why saving in
> word processor format might be bad....

hmm, the other thing i hate is policy. ever consider that
you're talking policy? maybe reboot() should sync() first?


> A notebook is a particularly bad example.  Those with notebooks
> might not want to use passwords all the time, but it is
> very convenient if you have to leave a notebook with sensitive data
> with someone you don't trust.  Business secrets or something
> as simple as a diary.  This kind of users can be logged in
> all the time, mostly avoiding passwords.  And log out
> in those few cases they need to leave the machine in
> unsafe places.

and that someone who had the notebook can't access sensitive
data without a passwd?
that's what i'm trying to say. if you carried your server,
and leave it in unsafe places, why would anybody try to crack
it? just get the harddisks put it in another computer, voila.
so much for security.


> > - linux is stable not only because security.
> Sure, but security definitely adds to its stability.

i don't know what you mean by stability. if you meant
linux can run a year without a reboot, what security
has anything to do with stability? the kernel is stable,
yes, do we here linux server got cracked yes, it's still
stable though.


> > - with that patch, people will still have authentication.
> >   so ssh for example, will still prevent illegal access, if
> Nope.  Someone ssh'ing into your system still
> cannot guess someone elses password.  They can log in
> into their own account though, and abuse other
> users accounts or the machine configuration because
> there is no protection.  Unprotected accounts only means
> you get your own account _by default_, you have the
> power to trash all the others.  A malicious user could
> even change the other users passwords and re-enable the
> security system so they loose.

i didn't disable password! if someone got into a personal
machine through ssh by guessing, most likely that account
is the owner's. who else?


>
> >   you had an exploit you're screwed up anyway.
> Many exploits are limited.  Cracking a damenon running
> as "nobody" or some daemon user may not be all that
> satisfying - you might be unable to take over the machine.
> An exploit doesn't necessarily give root access.

that line was still about ssh. besides, if someone would
run a server for the world, then he must had drain bamage.

> You get a lot of opinions.  Don't mistake them for flames
> just because they disagree with everything you say.

you haven't seen my inbox.


> Multi-user security is useful for much more than server use.
> A good "personal" setup includes at least 3 users:
> * root - for administration
> * the user - for running the programs the user himself use.
>   I.e. the word processor on a notebook, the user inteface
>   on a linux phone, and so on.
> * a nobody user, for safer daemons.  If any kind of daemon
>   is used at all.  Surprisingly many appliances might
>   run a daemon - a snmp daemon, or a webserver serving
>   the same purpose (So your can check your home
>   appliance from work perhaps)

but think about the idea of multi-user. it means protection
for the system and other users. that's a typical server needs.

and how about notebook? i can see that it need authentication
to use the system. does the user need to be protected from
other users? there's nobody else. well, maybe, like we all
used to, that user needed to protect him from himself.

so, system authentication is needed for both single-user and
multi-user. (let alone physical access)
user account authentication is certainly not needed for single-
user case.


> Of course passwords can be skipped - maybe you don't worry
> about guests messing up your phone settings.  Still, a buggy
> phone program shouldn't mess up other things.  You don't want
> the browser on those fancy web-enabled cellphones to
> accidentally delete the address book due to some oddball
> bug or exploit.

and you're hoping program with root suid will run perfectly?

> You don't want the performance _or_ less memory used.  Why then do
> you want to optimize away the security system instead of merely
> changing the userspace configuration a bit?
>
> If you optimize away security then you probably want to
> optimize away things like "login" as they are useless anyway
> with such a kernel.  Much simpler to remove only "login"
> then.

i wish it was only "a bit". what i want is to have all process
flags have PF_SUPERPRIV, but users still own their own uid.
doing it in userspace means i had to change this login, my
friend had to change that login, maybe this shell, that shell...

that's my setup. i still use login, so only those who i trust
can use my machine, yes my trusted user can do anything, but
hey it isn't a server. it's a workstation.



		imel


