Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135899AbRDTMlT>; Fri, 20 Apr 2001 08:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135898AbRDTMlD>; Fri, 20 Apr 2001 08:41:03 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:65482 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135896AbRDTMkq>;
	Fri, 20 Apr 2001 08:40:46 -0400
Message-ID: <3AE02E45.57D7BA9D@mandrakesoft.com>
Date: Fri, 20 Apr 2001 08:40:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-devel@lists.sourceforge.net,
        linux-power@phobos.fachschaften.tu-muenchen.de
Subject: Re: PCI power management
In-Reply-To: <Pine.LNX.4.10.10104191607280.7690-100000@nobelium.transmeta.com> <20010420120603.28316@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> >When a device comes out of D3[hot], the equivalent of a soft reset is
> >performed. From D3[cold], PCI RST# is asserted, and the device must be
> >completely reinitialized.
> 
> Some devices (bad bad HW designers ;) just can't do it themselves. The
> Rage M3 requires the host to assert PCI RST#, and some motherboards
> provide no documented facility for that (it might be possible with Apple
> ASICs for example, it's just not documented).

Why should we support such a non-spec device?  Tell ATI to fix their
hardware, and tell users (a) not to use the hardware, or (b) use the
hardware with the knowledge that you are screwed when it comes to Power
Management.

Unless there are more cases like this, this should not factor at all
into the modifications to the PCI and PM code...

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
