Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270622AbTGaXh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270623AbTGaXh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:37:58 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:35090 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S270622AbTGaXhz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:37:55 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Turning off automatic screen clanking
Date: Fri, 1 Aug 2003 00:35:06 +0100
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <20030731162037.GB32759@www.13thfloor.at> <3F297429.1010302@techsource.com>
In-Reply-To: <3F297429.1010302@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308010035.13158.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 Jul 2003 20:55, Timothy Miller wrote:
> Herbert Pötzl wrote:
> >>Why don't we borrow a trick from my old Atari 8-bit computer.  Instead
> >>of blanking, cycle the colors.  Best of both worlds:  You save your
> >>monitor AND you get to see what's on the screen.
> >
> > hmm, ignoring the issue that modern monitors will not
> > suffer the burnin, how would it help to cycle the colors?
> > the only valid solution would be inverting the image on
> > a regular basis, and I don't think that this would be
> > appreciated ...
>
> So, if there's no point to having screen-blanking, why is it in there to
> begin with?  To protect OLD monitors from burnin?
>
> Is screen-blanking there just to make people feel better who think they
> need screen-blanking?  As I understand, it doesn't do any
> power-management stuff anyhow.

You say that, and I certainly remember it saying just about the same thing in 
the kernel configuration help.  However there is also this from the Debian 
init file /etc/init.d/console-screen.sh

    # screensaver stuff
    setterm_args=""
    if [ "$BLANK_TIME" ]; then
        setterm_args="$setterm_args -blank $BLANK_TIME"
    fi
    if [ "$BLANK_DPMS" ]; then
        setterm_args="$setterm_args -powersave $BLANK_DPMS"
    fi
    if [ "$POWERDOWN_TIME" ]; then
        setterm_args="$setterm_args -powerdown $POWERDOWN_TIME"
    fi
    if [ "$setterm_args" ]; then
        setterm $setterm_args

I know for sure it worked with 2.4 and am fairly sure it still works with 
2.6.0-test#.

-- 
Ian.

