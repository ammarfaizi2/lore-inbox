Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRDPQAm>; Mon, 16 Apr 2001 12:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRDPQAd>; Mon, 16 Apr 2001 12:00:33 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:25618 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S130900AbRDPQAZ>;
	Mon, 16 Apr 2001 12:00:25 -0400
Date: Mon, 16 Apr 2001 17:49:45 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010416174945.D29398@kallisto.sind-doof.de>
Mail-Followup-To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20010413002920.C43@(none)> <Pine.LNX.4.31.0104161427400.13558-100000@phobos.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104161427400.13558-100000@phobos.fachschaften.tu-muenchen.de>; from Simon.Richter@phobos.fachschaften.tu-muenchen.de on Mon, Apr 16, 2001 at 02:42:03PM +0200
X-Operating-System: Debian GNU/Linux (Linux 2.4.3-ac5-int1-nf20010413-dc1 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 16, 2001 at 02:42:03PM +0200, Simon Richter wrote:
> 
> A power failure is a different thing from a power button press. There are
> users (me for example) who want to have something different then "init 0"
> mapped to the power button, for example a sleep state (since my box
> doesn't have a dedicated sleep button). I doubt there are many people who
> want something else than a shutdown if the power is out (although I think
> there will be with suspend-to-disk working, so we might have to change UPS
> handling here).

And why not do exactly this with init? Have a look in /etc/inittab:

% grep power /etc/inittab
# What to do when the power fails/returns.
pf::powerwait:/etc/init.d/powerfail start
pn::powerfailnow:/etc/init.d/powerfail now
po::powerokwait:/etc/init.d/powerfail stop

You can shut down your machine there, but you can also have it play a
cancan on power failure. It is up to your gusto. And now tell me, why
not choose a similar approach, but instead reinvent the wheel and
create a completely new mechanism?

Andreas
-- 
Besides, I think Slackware sounds better than 'Microsoft,' don't you?
	-- Patrick Volkerding

