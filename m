Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135830AbRDTJCv>; Fri, 20 Apr 2001 05:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135832AbRDTJCl>; Fri, 20 Apr 2001 05:02:41 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:4622
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S135830AbRDTJCc>;
	Fri, 20 Apr 2001 05:02:32 -0400
Date: Fri, 20 Apr 2001 02:02:25 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] FW: proposal for systems that do not require security
Message-ID: <20010420020225.G8578@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	"Heusden, Folkert van" <f.v.heusden@ftr.nl>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <27525795B28BD311B28D00500481B7601F11A6@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <27525795B28BD311B28D00500481B7601F11A6@ftrs1.intranet.ftr.nl>; from f.v.heusden@ftr.nl on Tue, Apr 10, 2001 at 02:35:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 02:35:52PM +0200, Heusden, Folkert van wrote:
> So, I was wondering: isn't it a nice idea to have a switch in the
> configuration menu to disable entropy-gathering in the interrupt-routines,
> have some simplistic routine (like x'=(x * m + a) % p) which returns a non-
> cryptographic value, and something similar symplistic for the network-
> traffic routines?

No, that's a very bad idea.  If you think it's a problem, just remove
the random driver altogether.  It's much better for something to get
ENXIO rather than thinking it's getting real randomness.

You can still get TCP sequence numbers by sampling the cycle counter or
something.

	J
