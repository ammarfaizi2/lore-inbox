Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSEPFMo>; Thu, 16 May 2002 01:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSEPFMn>; Thu, 16 May 2002 01:12:43 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:49290 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316577AbSEPFMl>; Thu, 16 May 2002 01:12:41 -0400
Date: Thu, 16 May 2002 07:23:04 +0200
From: Michael Schlenstedt <mailinglists_michael@schlenn.net>
To: linux-kernel@vger.kernel.org
Subject: Re: please help with pppoe
Message-ID: <20020516072304.A911@schlenn.net>
Mail-Followup-To: Michael Schlenstedt <mailinglists_michael@schlenn.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205151214.AA22282484@imail.ricis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: SuSE Linux 7.3 (i386) -- Kernel 2.4.10-4GB
Organization: http://www.schlenn.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit Mai 15, 2002, lee Leahu  <lee@ricis.com> wrote:
> 
> i have these packages installed
> smpppd-0.49-7 (and yes, smpppd is running)
> ppp-2.4.1-170
> rp-pppoe-3.4-1
^^^^^^^^^^^^^^^

You don't need this, if you want to use kernel-pppoe. This is another
userspace-driver.

> my /etc/ppp/options file goes like this:
> 
> hide-password
> lock
> local
> nocrtscts
> sync
> noauth
> noaccomp
> mtu 1484
> mru 1484

Change this to 1492. You also have to add the PPPoE-Modul. You'll find a
working config-file at [1]. Unfortunately with german comments, have a
look in "man pppd" to figure out what all the options stand for. It
could also be useful to activate "debug" and "kdebug 4" in the
options-file. So you'll get a lot of interesting infos in
/var/log/messages

> noipdefault
> noipx
> novj
> novjccomp
> debug
> username "(username)@covad.net"
^^^^^^^^^^
This have to be:  user "(username)@covad.net" (see [1]).

> i have been trying to get this pppoe to work by running:
> pppoe -I eth1
> pppoe -D -d 9 -I eth1

These are for Kernel-PPPoE with Kernel 2.2.x! With the options-file
above you only have to use "pppd eth1".

> adsl-start

This is for rp-pppoe, not for Kernel-PPPoE!

> please help

Maybe you should post to the ppp-Mailinglist (linux-ppp at
vger.kernel.org).

Bye,
Michael



In-Reply-To:
  1. http://www.adsl4linux.de/pub/config/pppoed24x/tonline_tdsl/options

-- 
ADSL4Linux:                http://www.adsl4linux.de
Erste Hilfe im Webforum:   http://www.adsl4linux.de/forum
ADSL4Linux-Mailinglisten:  http://www.adsl4linux.de/majordomo
Lob/Kritik/Sonstiges:      feedback@adsl4linux.de
