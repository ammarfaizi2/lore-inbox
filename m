Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbRETOr2>; Sun, 20 May 2001 10:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262002AbRETOrT>; Sun, 20 May 2001 10:47:19 -0400
Received: from pD951F76E.dip.t-dialin.net ([217.81.247.110]:18948 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S261977AbRETOrG>; Sun, 20 May 2001 10:47:06 -0400
Date: Sun, 20 May 2001 16:47:02 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Donald Becker <becker@scyld.com>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: RTL8139 difficulties in 2.2, not in 2.4
Message-ID: <20010520164702.A1569@emma1.emma.line.org>
Mail-Followup-To: Donald Becker <becker@scyld.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, jgarzik@mandrakesoft.com
In-Reply-To: <20010519140413.B1795@emma1.emma.line.org> <Pine.LNX.4.10.10105191107450.956-100000@vaio.greennet> <20010520122759.B2910@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010520122759.B2910@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sun, May 20, 2001 at 12:27:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Matthias Andree wrote:

> > > eth1: Transmit timeout, status 0c 0005 media 18.

It looks like I found a workaround which may help you debugging, if new
questions arise, please ask. Willing to help so this issue can be
resolved for Linux 2.2.20.

1. I'm compiling my eth drivers as modules.

2. I alias eth0 to 3c59x and eth1 to either 8139too or rtl8139 (doesn't
matter); my rtl8139 is the current version 1.13 from scyld.com

3. after X has come up, I issue "ifconfig eth1 down; rmmod rtl8139" (or
8139too, depending on what modules.conf says)

4. I do "ifconfig eth1 up" (pppoe with Deutsche Telekom AG doesn't
require IP, just raw ethernet)

5. I launch pppd which runs pppoe, the problems are gone.

I haven't yet checked if after this procedure, 3D graphics work out, I
don't have current NVidia drivers here, just plain XFree 4.0.3 as
packaged by SuSE.
