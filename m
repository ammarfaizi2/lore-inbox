Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVIAOqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVIAOqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbVIAOqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:46:11 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:24499 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S965147AbVIAOqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:46:10 -0400
Date: Thu, 1 Sep 2005 16:49:56 +0200
From: DervishD <lkml@dervishd.net>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Storage speed regression since 2.6.12
Message-ID: <20050901144956.GB83@DervishD>
Mail-Followup-To: Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050901113614.GA63@DervishD> <4316EAD1.70300@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4316EAD1.70300@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Salut Brice :)

 * Brice Goglin <Brice.Goglin@ens-lyon.org> dixit:
> Le 01.09.2005 13:36, DervishD a écrit :
> >     The lack of speed seems to affect only the OHCI driver. My test
> > was done over a PCI USB 2.0 card, ALi chipset, OHCI driver (well
> > EHCI+OHCI) and using a full speed device capable of 12MBps. The
> > average measured speeds are:
> > 
> >     - 2.4.31:           about 450Kb/seg
> >     - 2.6.11-Debian:    about 800Kb/seg
> >     - 2.6.11.12:        about 820Kb/seg
> >     - 2.6.12.x:         about 200Kb/seg
> >     - 2.6.13:           about 200Kb/seg
> Are you mounting this storage with vfat and 'sync' option ?

    Yes, that may be the problem, but I think that is not the only
problem, see below.

> IIRC, sync support for vfat was added around 2.6.12, making
> write way slower since it's now really synchron.

    The fact is that if I mount the device under 2.4.31 using the
'sync' option, the speed are the ones shown above, but if I mount
them with 'async', the speed is that of the light ;) I mean, the
'sync' option is doing something even in 2.4.31. The same applies to
2.6.11, but I have to test in 2.6.12 & 13.

    Thanks for your help. If the problem is just that, the sync
option, I'll drop a note to the mailing list. Merci mille fois ;)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
