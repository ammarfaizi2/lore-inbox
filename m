Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264670AbRFPVdE>; Sat, 16 Jun 2001 17:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbRFPVcy>; Sat, 16 Jun 2001 17:32:54 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:218 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S264661AbRFPVch>;
	Sat, 16 Jun 2001 17:32:37 -0400
Message-ID: <3B2BD058.22E4A9EA@mandrakesoft.com>
Date: Sat, 16 Jun 2001 17:32:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <15145.1739.395626.842663@pizda.ninka.net>
		<200106141904.f5EJ4AD413350@saturn.cs.uml.edu>
		<15145.3254.105970.424506@pizda.ninka.net>
		<3B29137B.CA8442B8@mandrakesoft.com>
		<15145.5939.879723.656331@pizda.ninka.net>
		<3B2919B8.85D38801@mandrakesoft.com> <15145.6960.267459.725096@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Jeff Garzik writes:
>  > ok with me.  would bus #0 be the system or root bus?  that would be my
>  > preference, in a tiered system like this.
> 
> Bus 0 is controller 0, of whatever bus type that happens to be.
> If we want to do something special we could create something
> like /proc/bus/root or whatever, but I feel this unnecessary.

Basically I would prefer some sort of global tree so we can figure out a
sane ordering for PM.  Power down the pcmcia cards before the add-on
card containing a PCI-pcmcia bridge, that sort of thing.  Cross-bus-type
ordering.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
