Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUHGCy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUHGCy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 22:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUHGCy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 22:54:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39312 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265928AbUHGCy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 22:54:26 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>
In-Reply-To: <s5hfz75sh30.wl@alsa2.suse.de>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe> <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe>  <s5hfz75sh30.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1091847265.949.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 06 Aug 2004 22:54:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 11:19, Takashi Iwai wrote:
> At Fri, 30 Jul 2004 18:54:39 -0400,
> Lee Revell wrote:
> > 
> > I discovered that a few of the XRUN traces were spurious - jackd
> > apparently does something while stopping and starting that produces an
> > XRUN trace but that jackd does not consider an error.  I will fix this
> > in jackd.  The msync() related XRUN triggered by apt-get is definitely
> > real.
> 
> Yes.  There is a bogus report at stopping (snd_pcm_drain is called).
> It was fixed in the recent ALSA cvs tree, but seems not propagated to
> bk yet...
> 

It also seems to produce an xrun at startup.  This is with the latest
ALSA CVS.  Is this behavior by design?

Lee

