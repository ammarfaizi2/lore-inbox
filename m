Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933330AbWKNDKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330AbWKNDKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 22:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933333AbWKNDKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 22:10:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:63928 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S933330AbWKNDKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 22:10:02 -0500
X-Sasl-enc: eRb28DGhv9otxyZ9JuWP2yrCY/DudiPjadrhX15lyzMS 1163473802
Date: Tue, 14 Nov 2006 01:09:53 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Stelian Pop <stelian@popies.net>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Apple Motion Sensor driver
Message-ID: <20061114030953.GA5810@khazad-dum.debian.net>
References: <1163280972.32084.13.camel@localhost.localdomain> <20061113190635.597ab587.khali@linux-fr.org> <1163450519.23807.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163450519.23807.11.camel@localhost.localdomain>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, Stelian Pop wrote:
> I do believe that the proper place for ams is the hardware monitoring
> section (even if the missing HD parking APIs makes it not very useful
> right now).
> 
> The fact that the accelerometer offers a (low res) joystick emulation is
> only a nice hack and I'm not even sure somebody (except Johannes) will
> find an use for it.

Sort of.  Some accelerometers actually act more as input devices than as
monitoring devices.  E.g. HDAPS has no intelligence whatsoever about what is
happening (it doesn't to any sort of threshold detection, unlike Apple's
motion sensing stuff), but it can give you reasonable resolution at a
maximum sample rate of 500Hz (I don't recommend getting it to go that fast,
though) for two axis, with configurable running-averaging.  Looks a lot more
like a joystick to me than a hardware monitoring sensor.

It's just a matter of PoV, and one can easily make a case for accelerometers
to live in either hwmon or input.   As long as they're all in one place :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
