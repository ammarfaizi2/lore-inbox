Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWBTJj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWBTJj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWBTJj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:39:28 -0500
Received: from canadatux.org ([81.169.162.242]:15541 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S932376AbWBTJj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:39:27 -0500
Date: Mon, 20 Feb 2006 10:39:11 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220093911.GB19293@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060218142610.GT3490@openzaurus.ucw.cz>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, Feb 18, 2006 at 03:26:11PM +0100, Pavel Machek wrote:
> Thanks for a fresh air in this flamewar...

Well, I would more like a technical based discussion instead of
flamming. As I said previously, why not have both swsusp and suspend 2
in mainline, as they can coexists without any problem.

> > I have to completly agree with Sebastian here. 16 months ago I was
> > in the need to have a suspend mode running on my new notebook. Back
> > then Suspend 2 was the only choice, and while it had still problems
> > it was surprisingly well behaving (in contrast to S3 mode and the
> > mainline swsusp). The support of the community was, as said above,
> > very good, and most issues very fixed fast.
> 
> Can you test recent swsusp?

Maybe I will, but my current setup does not allow this. When Fedora Core
5 comes out in some weeks I will give it a try. But as said, what I want
is a stable and reliable suspend, not something that works in "most of
the cases". Suspend 2 has proved to me and others that is stable.

(BTW: in the last 200 cycles I did with various Suspend 2 versions I had
exactly 1 (_one_) "failure" (Xorg crashed on resume and I had to restart
my windowmanager). That "failure" was not even Suspend 2 related, but a
small bug in Xorg which got already fixed in the meantime.

> > Since it worked good for me, I started to contribute by supplying
> > Fedora patched kernels, helper packages and some documentation.
> > Today on Fedora, it is as easy as installing 4 RPM-packages and
> > adding the "resume2=" parameter to the kernel commandline, and I
> > know that it works this well on several other distributions too.
> 
> ...well, thanks for your good work.

You are welcome.

> > Some more numbers: judging from my access logs and the feedback I
> > get, I suspect at least 2000 Fedora users using Suspend 2 on a
> > regular basis with success. Listening to the IRC channel and reading
> > the forums and wikis, I see a huge bunch of people using Suspend 2
> > on nearly every distribution. The problems are incredible low,
> > mostly minor things that get fixed nearly instantly.
> 
> Well, at least Fedora and SuSE ship swsusp by default. So it is
> getting huge ammount of testing, too.

No, I do not think so. I do not know about SuSE (although I think you
are right there), but Fedora does _not_ ship swsusp. It was rejected for
a long time because it was considered too dangerous. Recent rawhide as
enabled it, but I doubt there are as many testers for it as there are
for Suspend 2 (on Fedora). That might change with Core 5 (which is
scheduled to be released in March), but I think we have to wait for
that.

> > Some pros of Suspend 2 from my view:
> > - it is reliable and stable (really!)
> > - it is fast (10-30 seconds on my notebook with 1280 MB ram, depending
> >   on how much caches are saved)
> > - it can save all buffers and caches and the system is instantly
> >   responsible after resume (even Windows cannot do this and is very slow
> >   the first minute after resume)
> > - it works on all major platforms (x86, SMP, x86_64, there were success
> >   reports for PPC, and I believe even ARM works)
> > - and the most important thing, as already said, it is available _today_
> 
> swsusp is also available today, and works better than you think.

OK, I will give it a try in some weeks.

> It is slightly slower,

Sorry, but that is just unacceptable.

> > The only con I see is the complexity of the code, but then again,
> > Nigel
> 
> ..but thats a big con.

So why is that? From what I see, most of the code is completly independ
of the rest of the kernel, and just does not affect if it is disabled.

It won't do any harm to the kernel, and again, Nigel is constantly
improving that situation, so for sure, that is no _big_ con.

> > Again, you said the code is complex, it might be, but still most
> > part of the code is completly seperate from the rest of the kernel,
> > and only touches minor things (and Nigel is still working on that).
> > I believe it would not hurt.
> 
> It would hurt at least me, Andrew and Linus... It would make lot of
> suspend2 users very happy...

Why would it hurt? See above, I cannot see how Suspend 2 would affect
the rest of the kernel and hurt people who are just not using it.

> > From a user, and contributor, point of view, I really do not
> > understand why not even trying to push a working implementation into
> > mainline (I know that you cannot just apply the Suspend 2 patches
> > and shipping it,
> 
> It is less work to port suspend2's features into userspace than to
> make suspend2 acceptable to mainline. Both will mean big changes, and
> may cause some short-term problems, but it will be less pain than
> maintaining suspend2 forever. Please help with the former...

These "big changes" is something I have a problem with, since it means
to delay a working suspend/resume in Linux for another "short-term" (so
what does it mean: 1 month? six? twelve?). It is painful to get these
things to work reliable, I have followed this for nearly 1.5 years. And
again: today there is a working implementation, so why not merge it and
have something today, and then start working on the other things.

I would think that this would help both sides, as it would give us a
working implementation now, and in some time (I would like to believe
you, but sill think that it will take at least one year, maybe two,
until you have uswsusp work stable) the new implementation (and then we
can look which one works better, and maybe deprecate the other).

Regards,
Matthias
