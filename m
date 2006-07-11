Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWGKGNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWGKGNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWGKGNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:13:35 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:47260 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S965045AbWGKGNe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:13:34 -0400
Date: Tue, 11 Jul 2006 08:15:28 +0200
From: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
To: Valdis.Kletnieks@vt.edu
Cc: alsa-devel@alsa-project.org, ak@suse.de, linux-kernel@vger.kernel.org,
       rlrevell@joe-job.com, perex@suse.cz, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-Id: <20060711081528.4d3ab197.atlka@pg.gda.pl>
In-Reply-To: <200607110209.k6B29psN007504@turing-police.cc.vt.edu>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe>
	<44B2E4FF.9000502@pg.gda.pl>
	<200607110209.k6B29psN007504@turing-police.cc.vt.edu>
Organization: Gdansk University of Technology
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 22:09:51 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Tue, 11 Jul 2006 01:38:39 +0200, =?ISO-8859-2?Q?Adam_Tla=B3ka?= said:
> > U¿ytkownik Lee Revell napisa³:
> >
> > > esd and artsd are no longer needed since ALSA began to enable software
> > > mixing by default in release 1.0.9.
> >  >
> > 
> > So why they are still exist in so many Linux distributions?
> 
> As soon as somebody writes a patch to make the e16 window manager talk ALSA
> rather than use esd, I'm heaving esd over the side.

Sorry to say but it is just not that way. Window manager is for managing windows
and it shouldn't depend on any audio system. It should use an external app using exec call
to play sounds (aplay, sox, wavplay etc.) configured by some config option.
Generally it is a big mess in may distros where desktop apps depends on sound.
Yes, it is nice to have sound but it is not absolutly needed to use an editor for example. 

> Of course, I've been saying that since ALSA 1.0.9 came out.  (And don't
> suggest I write it myself - I could if I was motivated enough, but I'm not
> motivated at the current time. :)
> 

If you are the author then I just suggest to use exec(3) call, for example:

if (!fork()){
	execvp("aplay","beep.wav");
	exit(0);
}

Simple, and you don't need to know anything about sound programming ;-).

Regards
-- 
Adam Tla³ka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
