Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbVKHQKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVKHQKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVKHQKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:10:44 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16061 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030237AbVKHQKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:10:44 -0500
Subject: Re: 2.6.14-mm1 libata pata_via
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sander@humilis.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051108142140.GA2790@favonius>
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net>
	 <20051108121318.GB23549@favonius>
	 <1131455213.25192.26.camel@localhost.localdomain>
	 <20051108142140.GA2790@favonius>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 16:41:39 +0000
Message-Id: <1131468099.25192.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-08 at 15:21 +0100, Sander wrote:
> > Thats the important bit. It looks as if I got the timing clock loading
> > wrong for this chip. (My EPIA works nicely but all the info I need is in
> > your report).
> 
> Good to know.
> 
> I see your new patch against 2.6.14-mm1 has updates for pata_via.c. It
> does not address this issue I presume?

It may do because it adds per device tuning and in doing so makes sure
that no device calls are made before the speed setting of both devices
has been made.

