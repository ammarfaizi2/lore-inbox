Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261234AbREPMVE>; Wed, 16 May 2001 08:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbREPMUy>; Wed, 16 May 2001 08:20:54 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:15859 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S261234AbREPMUl>; Wed, 16 May 2001 08:20:41 -0400
Date: Wed, 16 May 2001 14:20:36 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Jonathan Lundell <jlundell@pobox.com>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <p0510033db727cdc4a244@[207.213.214.37]>
Message-ID: <Pine.LNX.4.33.0105161408570.10700-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Jonathan Lundell wrote:

> >The 2.4 kernel allows you to rename an interface.  So you can build
> >a little database of (MAC address/name) pairs. Apply this after booting
> >and before bringing up the interfaces and everything has the name
> >you wanted, based on MAC address.
>
> There's a bit of a catch 22, though, if you don't have unique MAC
> addresses in the system (across multiple interfaces).

The same situation appears when using bonding.o. For several years,
Don Becker's (and derived) network drivers support changing MAC address
when the interface is down. So Al's /dev/eth/<n>/MAC has different values
depending on whether bonding is active or not. Should /dev/eth/<n>/MAC
always have the original value (to be able to uniquely identify this card)
or the in-use value (used by ARP, I believe) ? Or maybe have a
/dev/eth/<n>/MAC_in_use ?

Sincerely,

Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De


