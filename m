Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268576AbTCDPTg>; Tue, 4 Mar 2003 10:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268635AbTCDPTf>; Tue, 4 Mar 2003 10:19:35 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:32774 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S268576AbTCDPTe>; Tue, 4 Mar 2003 10:19:34 -0500
Date: Tue, 4 Mar 2003 18:28:15 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: jamal <hadi@cyberus.ca>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, kuznet@ms2.inr.ac.ru,
       david.knierim@tekelec.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       Donald Becker <becker@scyld.com>, linux-kernel@vger.kernel.org,
       alexander@netintact.se, raarts@office.netland.nl
Subject: Re: PCI init issues
Message-ID: <20030304182815.A3829@jurassic.park.msu.ru>
References: <20030302121050.F61365@shell.cyberus.ca> <20030303151412.A15195@jurassic.park.msu.ru> <20030303203540.F67734@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030303203540.F67734@shell.cyberus.ca>; from hadi@cyberus.ca on Mon, Mar 03, 2003 at 08:48:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 08:48:16PM -0500, jamal wrote:
> Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B6,I4,P0) ->
> 96
> Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B6,I5,P1) ->
> 96
> Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B6,I6,P2) ->
> 96
> Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B6,I7,P3) ->
> 96
...
> BIOS irq assignments i suppose are validated.

No, this means that mp tables are broken in a way I didn't expect...
Also, it's unclear whether or not the IOxAPIC routing is broken as well.
Probably full dmesg output (especially things related to IO_APICs setup
and irq<->pin mapping) could shed some light on this.

> I have a feeling the reason it works in windows is because of a
> functional ACPI.

Perhaps.

Ivan.
