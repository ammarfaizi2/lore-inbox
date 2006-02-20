Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWBTMZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWBTMZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWBTMZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:25:05 -0500
Received: from canadatux.org ([81.169.162.242]:24555 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S964887AbWBTMZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:25:02 -0500
Date: Mon, 20 Feb 2006 13:24:43 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220122443.GB3495@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1140434146.3429.17.camel@mindpipe>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 06:15:46AM -0500, Lee Revell wrote:
> > That is all I complain about, it means throwing away everything that
> > is working, or easy to get it working, and delaying working
> > hibernate support for another time. 
> 
> But we have not established that the current implementation does not
> work!  That's a pretty strong assertion to make with zero evidence.

As I said, it did not work. Efforts to make it work just started
recently, at a time when Suspend 2 already was stable and reliable to
me.

But, ok. Rawhide kernel 2.6.15-1.1955_FC5, which should be pretty close
to what Fedora Core 5 will have (Dave might know this better).

The first try was a desaster, partly my own fault, partly because swsusp
does not allow abortion (remember what I said about having a least some
basic stuff in the kernel). However, I rebooted, fscked, no filesystem
corruption *phew*.

The second try worked, with ugly messages scrolling over the console,
but ok, Suspend 2 already fixes some drivers which has not yet been
merged to mainline. The system resumed, which is fine.

Third try sound was gone. On the fourth try the system hanged after
starting ppracer (to test GLX/DRI on my i855).

This is a much more recent kernel, than the ones I used with Suspend 2
for the last 1.5 problems. Problems discovered have been no issue with
Suspend 2 for at least 7 or 8 months (no single crash or driver
problems). This is mostly a driver issue and undoubtly can be solved,
but I still do not see how this can be done when all efforts are put
into just another suspend implementation (uswsusp).

Ah, and now the part I really like, some hard numbers:
swsusp takes between 26 and 30 seconds to suspend (in my four tries: 26,
30, 28, 26) and between 35 and 45 seconds to resume (35, 45, 39, 37).

Suspend 2 does suspend in around 14-16 seconds, and resume in 18 to 21.

That is factor 2!

Regards,
Matthias
