Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBOSse>; Thu, 15 Feb 2001 13:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbRBOSsO>; Thu, 15 Feb 2001 13:48:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129143AbRBOSsK>; Thu, 15 Feb 2001 13:48:10 -0500
Subject: Re: MTU and 2.4.x kernel
To: kuznet@ms2.inr.ac.ru
Date: Thu, 15 Feb 2001 18:47:31 +0000 (GMT)
Cc: roger@kea.GRace.CRi.NZ, linux-kernel@vger.kernel.org
In-Reply-To: <200102151821.VAA19711@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Feb 15, 2001 09:21:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TTRF-0000Ul-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with bogus mtu values sort of 552 or even 296, but also jailed them
> to some proxy or masquearding domain), but it is still right: IP
> with mtu lower 576 is not full functional.

Please cite an exact RFC reference.

The 576 byte requirement is for reassembled packets handled by the host.
That is if you send a 576 byte frame you know the other end will be able
to put it back together. Our handling of DF on syn frames is also broken
due to that misassumption, but fortunately only for crazy mtus like 70.

Alan

