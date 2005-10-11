Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVJKVN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVJKVN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVJKVN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:13:28 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:6771 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932326AbVJKVN1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:13:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a1KbVUmjT4VWuWHzXe2Jrr8/U1PJ/5HO17P01D7CfYBxx0re32QnwuQuPQLdCYhd2TJS+OITTvnxB8Mgcz+iiNd/g4DUd/q6N7m2r0oynbeugxFOYZhb77wk875oSdJZkHzN93eofi8Xfug0pgNUiQqafBCF7IGnjiGYrIFbzUE=
Message-ID: <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
Date: Tue, 11 Oct 2005 14:13:26 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.14-rc4-rt1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Mark Knecht <markknecht@gmail.com> wrote:
> On 10/11/05, Fernando Lopez-Lezcano <nando@ccrma.stanford.edu> wrote:
> > Hi Ingo, just a heads up, I'm still seeing the same problems I reported
> > with rt13. After about 10 to 15 minutes of up time I see the usual
> > warnings from Jack, keyboard repeat problems (repeats keys too fast) and
> > random screensaver triggers. The last two seem to be "clustered" in
> > time, for a little while things work, then both happen and so on and so
> > forth.
> >
> > Sorry to not have any traces that could help, I'm still too busy to be
> > able to sit down quietly and gather data.
> > -- Fernando
>
> Very strange. I've had Jack running at 64/2 since 8:52AM this morning.
> Not a single xrun. I've had Ardour looping a session as well as
> Aqualung playing a long playlist. No changes in the config file form
> the one I sent you off line a couple of days ago.
>
> Guess I'm lucky.
>
Absolutely amazing!!! Not two minutes after sending the previous email
I got two xruns clustered together:

nperiods = 2 for capture
nperiods = 2 for playback
08:52:03.281 Server configuration saved to "/home/mark/.jackdrc".
08:52:03.282 Statistics reset.
08:52:03.437 Client activated.
08:52:03.438 Audio connection change.
08:52:03.441 Audio connection graph change.
08:52:10.264 Audio connection graph change.
08:52:10.271 Audio connection change.
08:52:10.277 Audio connection graph change.
08:52:10.472 Audio connection change.
08:52:12.562 Audio connection graph change.
09:07:40.707 MIDI connection graph change.
09:07:40.714 MIDI connection change.
09:07:41.517 Audio connection graph change.
09:12:35.216 Audio connection graph change.
09:12:35.272 Audio connection change.
10:28:05.229 Audio connection graph change.
10:28:05.429 Audio connection change.
10:29:08.091 Audio connection graph change.
10:29:08.159 Audio connection change.
10:29:15.992 Audio connection graph change.
10:29:16.020 Audio connection change.
10:29:16.020 Audio connection graph change.
10:29:16.268 Audio connection change.
10:29:16.307 Audio connection graph change.
10:29:16.519 Audio connection change.
subgraph starting at ardour timed out (subgraph_wait_fd=20, status =
0, state = Finished)
14:06:43.636 XRUN callback (1).
14:06:43.637 XRUN callback (2).
**** alsa_pcm: xrun of at least 0.728 msecs
**** alsa_pcm: xrun of at least 5.548 msecs

The machine had been essentially 'User space idle' for the previous
two hours. The screen saver had kicked in. Audio was running and the
machine was busy. I woke it up, gave xscreensaver my password, read
email, sent the previous mail, then picked up the telephone to make a
call. Not 2 seconds later the xruns occurred!

Bizarre!!!

- Mark
