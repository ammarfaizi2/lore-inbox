Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWBTOnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWBTOnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWBTOnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:43:01 -0500
Received: from canadatux.org ([81.169.162.242]:45965 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S1030258AbWBTOnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:43:00 -0500
Date: Mon, 20 Feb 2006 15:42:44 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220144244.GA6092@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <20060220122443.GB3495@kobayashi-maru.wspse.de> <20060220132842.GC23277@atrey.karlin.mff.cuni.cz> <20060220135145.GA5534@kobayashi-maru.wspse.de> <20060220140719.GA31319@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060220140719.GA31319@atrey.karlin.mff.cuni.cz>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 03:07:19PM +0100, Pavel Machek wrote:
> > On Mon, Feb 20, 2006 at 02:28:42PM +0100, Pavel Machek wrote:
> > What? That Suspend 2 was stable for me that time? Yes, it definitly
> > was. The same time when swsusp failed dramatically here, if there
> > was progress I could not see it that time.
> 
> "That efforts to fix swsusp only started recently" part is untrue.
> Driver work was pretty much done from the time swsusp was merged, and
> is ongoing.

As I did not really follow the ongoing work that time I will believe you
here.

So I am left to my statement that Suspend 2 worked for nearly one year,
where swsusp still has issues.

> You should be able to ^c resume script, too. (But that's going to
> cause problems anyway, no?)

In this case swsusp wanted to restore an already invalid image (had a
reboot with fsck before) which would have resulted in filesystem
corruption. If you are able to stop the resume process with ^C that is
fine, but that needs the "ugly" eventhandler in the kernel (which I
think is not so ugly at all).

As I said, this situation was partly my own fault, and we do not need to
discuss this further. It just reminds me on the bad things that could be
happen.

> > Nigel did, that is why the patch is so huge.
> 
> No, he did not. Driver fixes should be sent to relevant maintainers,
> not as a part of "suspend2 -- merge this"...

I think most patches were already submitted upstream. And I think we all
agree that this is the way how it should happen.

So, cleanups are still necessary, and I believe Nigel mentioned that he
is already working on it.

> > But then again, this was about work/not work, and there are still
> > problems, so there is still efford needed. In this situation it is
> > not good to just start over, but take the things that are already
> > there and work with it.
> 
> I seen Nigel's recent patch. Yes, it is easier to just start over.
> (8000 unneccessary lines... that's 3 times size of swsusp with uswsusp
> included!)

Correct me if I am wrong, but I see your comments are about Suspend 2.2,
while a lot of this was already be fixed in 2.2.0.1.

And Nigel has taken your points and preparing a new patch. So let see
when it is ready.

> > > Anyway uswsusp solves that issue.
> > 
> > Maybe it will, but when?
> 
> It works today, try it.

Using -mm is not an issue for me at the moment, so I cannot test it. I
will believe you with that, however I doubt that uswsusp is in any
better state than Suspend 2 when it comes to stability, reliabilty,
documentation and availability of working packages (at least I see no
userbase).

I do not say that uswsusp will not work, or never will, but I say that
it is far from finished, that is why it should be considered to use the
other solution first.

> > And here is my point again: take the easiest way to make hibernation
> > working fast, and when that is done start to work on any new
> > implementation.
> 
> I'm not interested in "easiest way to fast hibernation". I'm
> interested in "right way to fast hibernation".

OK, for me the "right way" is to take the working solution and work
around the problems and issues that are left and prevent it from getting
into mainline.

Regards,
Matthias
