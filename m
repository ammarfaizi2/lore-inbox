Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316495AbSEOUnd>; Wed, 15 May 2002 16:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316496AbSEOUnc>; Wed, 15 May 2002 16:43:32 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:20932 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S316495AbSEOUn3>; Wed, 15 May 2002 16:43:29 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "lee Leahu " <lee@ricis.com>
Subject: Re: please help with pppoe
Date: Wed, 15 May 2002 22:43:20 +0200
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205152243.20100.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 May 17:14, lee Leahu wrote:

LKM is the wrong place, but...

> i am running suse 7.3 professional.
> my kernel is 2.4.16-4gb (k_deflt made by suse)

First you should look at www.suse.de/www.suse.com.
They have a very good support database:
http://sdb.suse.de/en/sdb/html/index.html

> i have these packages installed
> smpppd-0.49-7 (and yes, smpppd is running)
> ppp-2.4.1-170

Good.

> rp-pppoe-3.4-1

Don't needed any more.

> my /etc/ppp/options file goes like this:
[-]
> mtu 1484
> mru 1484

As example for the German Telecom you need:

mtu 1492
mru 1492

It belongs into: /etc/ppp/peers/pppoe
#
# PPPoE options
#
plugin pppoe.so
#
# Plugin enables us to pipe the password to pppd, thus we don't have
# to put it into pap-secrets and chap-secrets. User is also passed
# on command line.
#
plugin passwordfd.so
#
noauth
usepeerdns
mru 1492
mtu 1492
# this is recommended
defaultroute
replacedefaultroute
hide-password
nodetach
# switch off all compressions (this is a must)
nopcomp
# this is recommended
novjccomp
noccp

> my /etc/ppp/pap-secret is like this
>
> "(username)@covad.net"     *      "(password)"

pap-secret is empty autogenerate with YaST2 (SuSE 7.3)

> i have been trying to get this pppoe to work by running:
> pppoe -I eth1
> pppoe -D -d 9 -I eth1
> adsl-start

Try with YaST/YaST2 (in this order).

Good luck.
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
