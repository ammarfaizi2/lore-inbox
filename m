Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVA0Kjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVA0Kjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVA0Kif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:38:35 -0500
Received: from dns.communicationvalley.it ([194.246.127.2]:24014 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S262562AbVA0KYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:24:34 -0500
From: Biker <biker@villagepeople.it>
To: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [BUG] 2.6.11-rc2 ALSA
Date: Thu, 27 Jan 2005 11:23:06 +0100
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
References: <20050126233524.232dcca0.akpm@osdl.org> <Pine.LNX.4.58.0501270837240.1743@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.58.0501270837240.1743@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501271123.08615.biker@villagepeople.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 08:46, Jaroslav Kysela wrote:
> On Wed, 26 Jan 2005, Andrew Morton wrote:
> > Hello list,
> > after upgrading to 2.6.11-rc2 my soundcard doesn't work anymore:
> >
> > I get this message during initialization of ALSA:
> >
> > /usr/sbin/alsactl: set_control:805: warning: name mismatch (External
> > Amplifier/Headphone Jack Sense) for control #26
> >
> > The soundcard is integrated on my thinkpad centrino notebook (R50), lspci
> > reports this:
> >
> > Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> >
> > If I boot back to 2.6.10 the PCM control has the volume set to zero, but
> > readjusting it to a normal value brings everything back to normal.
>
> It's probably already fixed in our CVS and ALSA BK tree:

Ok, thanks all.

-Silla

>
> =====
> revision 1.69
> date: 2005/01/17 13:47:20;  author: tiwai;  state: Exp;  lines: +14 -2
> Summary: Fix silent output on some machines with AD1981x codecs
>
> Fixed the default state of "Headphone Jack Sense" switch on AD1981x
> codecs.  Setting this on affects the output of some machines (e.g.
> Thindpads).
>
> The default value is set on only hardwares which are known to work.
> =====
>
>       Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
