Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264513AbRFJKKr>; Sun, 10 Jun 2001 06:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264514AbRFJKKg>; Sun, 10 Jun 2001 06:10:36 -0400
Received: from ppp-127-134.15-151.iol.it ([151.15.134.127]:13442 "HELO
	igor.opun.it") by vger.kernel.org with SMTP id <S264513AbRFJKKV>;
	Sun, 10 Jun 2001 06:10:21 -0400
Message-ID: <3B23477F.443D5FC8@alsa-project.org>
Date: Sun, 10 Jun 2001 12:10:07 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Zach Brown <zab@zabbo.net>
Cc: Ben Pfaff <pfaffben@msu.edu>, Lukas Schroeder <lukas@edeal.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] ess maestro, support for hardware volume control
In-Reply-To: <200106091931.f59JVw731673@devserv.devel.redhat.com> <87elst2vr2.fsf@pfaffben.user.msu.edu> <20010609185240.A23980@erasmus.off.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
> 
> > I now have a patch that will output the hwv buttons pressed (up,
> > down, mute) to a new dynamically allocated misc device as letters
> > u, d, m, instead of directly modifying the mixer.  Anyone want
> > that?  It's more flexible than either the patch that's currently
> > in -ac or Lukas's patch, but you need a little userspace daemon
> > for it to do anything useful.
> 
> hmm.. how do the alsa guys deal with hw volume?  I'm not sure I like
> adding more stuff to the OSS API.

It's a control separated from master volume. Often there is another
control that control if the two are linked.

Application may ask notification for controls changes (like the hw
volume one). This imply that an interrupt is related to this event.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
