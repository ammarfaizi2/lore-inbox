Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135912AbRD3VbO>; Mon, 30 Apr 2001 17:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135914AbRD3VbF>; Mon, 30 Apr 2001 17:31:05 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:30224 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S135912AbRD3Vaw>;
	Mon, 30 Apr 2001 17:30:52 -0400
Date: Mon, 30 Apr 2001 23:04:41 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "David S. Miller" <davem@redhat.com>,
        Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'Kenneth Johansson'" <ken@canit.se>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010430230441.A12723@kallisto.sind-doof.de>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	"David S. Miller" <davem@redhat.com>,
	Torrey Hoffman <torrey.hoffman@myrio.com>,
	'Kenneth Johansson' <ken@canit.se>,
	Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15085.47104.75880.572242@pizda.ninka.net> <Pine.LNX.3.95.1010430151259.15968A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010430151259.15968A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Apr 30, 2001 at 03:14:25PM -0400
X-Operating-System: Debian GNU/Linux (Linux 2.4.4-int1-vlan101-nf20010428 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 30, 2001 at 03:14:25PM -0400, Richard B. Johnson wrote:

> > mv /wherever/exeimage /usr/bin/exeimage
[...]
> > This is also basically how things like libc get installed.
> > A single mv is not only preserves currently referenced contents,
> > it is atomic.

One restriction: /wherever and /usr/bin must be on the same partition,
otherwise the mv will be the same as "rm /usr/bin/exeimage && cp
/wherever/exeimage /usr/bin/exeimage && rm /wherever/exeimage", which
is for sure not atomic.

> Sure, but now you can't get back if the new software doesn't run.
> This is why I recommended the two steps and cautioned about testing
> the new stuff first.

Then create a hardlink first, to keep a backup _and_ atomically
replace the file.

Andreas
-- 
Build a system that even a fool can use and only a fool will want to use it.

