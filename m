Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272818AbTHKSSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272790AbTHKSSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:18:16 -0400
Received: from maile.telia.com ([194.22.190.16]:64197 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S272945AbTHKSRI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:17:08 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O14int [SCHED_SOFTRR please]
Date: Mon, 11 Aug 2003 20:19:38 +0200
User-Agent: KMail/1.5.9
References: <200308091036.18208.kernel@kolivas.org> <5.2.1.1.2.20030810122144.019bdb00@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030810122144.019bdb00@pop.gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308112019.38613.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 August 2003 13.17, Mike Galbraith wrote:
> At 01:48 AM 8/10/2003 -0700, Simon Kirby wrote:
> >I am seeing similar starvation problems that others are seeing in these
> >threads.  At first it was whenever I clicked a link in Mozilla -- xmms
> >would stop, sometimes for a second or so, on a Celeron 466 MHz machine.
>
> Do you see this with test-X and Ingo's latest changes too?  I can only
> imagine one scenario off the top of my head where this could happen; if
> xmms exhausted a slice while STARVATION_LIMIT is exceeded, it could land in
> the expired array and remain unserviced for the period of time it takes for
> all tasks remaining in the active array to exhaust their slices.  Seems
> like that should be pretty rare though.
>

xmms is a RT process - it does not really have interactivity problems...
It will be extremely hard to fix this in a generic scheduler, instead
let xmms be the RT process it is with SCHED_SOFTRR (or whatever
it will be named).
Do this for arts, and other audio/video path applications.

Then start the race for interactivity tuning
 (X, X applications, console, login, etc)

interactivity = two-way
	http://www.m-w.com/cgi-bin/dictionary?va=interactive

Listening to music is not interactive.

Changing equalization on a media playback need to be interactive in
two ways.
1) The slider should move in the GUI.
2) The volume should change, but the big buffers needed in todays audio path
   will delay the audible changes...
Note: audio path starvation is not one of them...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
