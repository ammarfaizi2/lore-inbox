Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136448AbREDQf1>; Fri, 4 May 2001 12:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136449AbREDQfR>; Fri, 4 May 2001 12:35:17 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:2977 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136448AbREDQfJ>; Fri, 4 May 2001 12:35:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: dhcp problem with realtek 8139 clone with rh 7.1
In-Reply-To: <200105041520.f44FKUM07323@bastable.devel.redhat.com>
In-Reply-To: <200105041520.f44FKUM07323@bastable.devel.redhat.com>
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Date: 04 May 2001 18:35:05 +0200
Message-ID: <87lmod2hty.fsf@kosh.ultra.csn.tu-chemnitz.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael K. Johnson <johnsonm@redhat.com> writes:

> >I have som problem with my realtek 8139 clone. It won't work with
> >dhcp against my isp. [...]
> > 
> >Determining IP configuration... Operation failed. 
> 
> This sounds more like pump failing to negotiate dhcp properly than
> like a failure in the driver. Let's check that possibility first
> before assuming a driver bug.

It happens here also, but it does not seem to be a pump issue:

- I am using dhcpcd  ;)

- DHCP with 2.4.3 works fine

- The packages sent by the DHCP-server are having the correct destination
  MAC, but 'tcpdump' on the RTL8139 machine does not see them unless the
  promiscous mode ist enabled. When putting the NIC into promiscous mode,
  DHCP works fine[1].

- After the DHCP info are fetched and the IP is set, the promiscous mode
  can be turned off.

- When setting the IP statically things are working without turning on
  promiscous mode





Enrico
