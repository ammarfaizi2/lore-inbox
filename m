Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTIZKvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 06:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTIZKvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 06:51:35 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:57490 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262055AbTIZKvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 06:51:32 -0400
Date: Fri, 26 Sep 2003 12:51:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030926105121.GA9334@ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t> <20030926102403.GA8864@ucw.cz> <1064572898.21735.17.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1064572898.21735.17.camel@ulysse.olympe.o2t>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 12:41:38PM +0200, Nicolas Mailhot wrote:
> Le ven 26/09/2003 ? 12:24, Vojtech Pavlik a écrit :
> > On Fri, Sep 26, 2003 at 11:43:43AM +0200, Nicolas Mailhot wrote:
> > > Vojtech Pavlik  wrote:
> 
> [...]
> 
> > > Couldn't it at least detect there's a problem ? Most people I know do not press a key
> > > 2000+ times in a row during normal activity.
> > 
> > You do. Scrolling up/down in a document is one example. And there is no
> > point to limit the repeat to say 80 or 200 characters. You would still
> > hate having 80 repeated characters and then it stopping.
> 
> Well then only allow monster autorepeats for arrows then.
> (they are never stuck in my board anyway;)
> 
> > The problem really is there is no way to detect it. My latest patches
> > should fix this for AT keyboards by not using software autorepeat for
> > them.
> > 
> > Of course this won't fix any problems with USB, if there are still any.
> > My USB keyboard works just perfectly, no problems with the autorepeat.
> 
> Well mine doesn't:(. I seem to have gathered from past threads that HID
> makes the full keyboard status available at all time (unlike AT which
> only provides push/release events). Couldn't the repeat code just
> double-check the key is really stuck every ten repeats for example ?

It provides the full state when the state changes. If you miss the
change on release ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
