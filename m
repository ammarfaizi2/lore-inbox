Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132017AbQKQLZz>; Fri, 17 Nov 2000 06:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132028AbQKQLZq>; Fri, 17 Nov 2000 06:25:46 -0500
Received: from mail.zmailer.org ([194.252.70.162]:14347 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132003AbQKQLZb>;
	Fri, 17 Nov 2000 06:25:31 -0500
Date: Fri, 17 Nov 2000 12:55:18 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Robert Cohen <robert@coorong.anu.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux and 802.IQ
Message-ID: <20001117125518.I28963@mea-ext.zmailer.org>
In-Reply-To: <3A14EE30.C1E65B84@tltsu.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A14EE30.C1E65B84@tltsu.anu.edu.au>; from robert@coorong.anu.edu.au on Fri, Nov 17, 2000 at 07:37:04PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 07:37:04PM +1100, Robert Cohen wrote:
> I have been looking into VLANS on some switches. Apparently on these
> switches, a host can only be a member of two vlans if it is 802.IQ
> compliant (or have 2 NIC's, one into each vlan). Its not clear from the
> docs whether the OS has to be 802.IQ compliant or if its an attribute of
> the NIC.

   Oh, you mean  IEEE 802.1q VLAN trunking protocol ?

> Anyway is Linux 802.IQ compliant? Is Linux 2.2 or just 2.4.
>  How long has 802.IQ been around and how widespread is it. Is Solaris
> compliant. How about NT/ Win 2000.

   The baseline Linux is not, but there has been external development
   activity to create patches supporting vlan-trunk interfacing.
   In fact TWO separate patches, which now do share some code:

	http://scry.wanfear.com/~greear/vlan.html
	http://vlan.sourceforge.net/


   I have seen VLAN trunking implemented at some network cards for
   Solaris (gigabit cards mainly), similar is propably true for
   the windows world.    Common thing there is that the DRIVER creates
   an illusion of having gazillions of network devices, each plain
   simple ethernet device.

   Linux is slightly different from that model by having generalized
   802.1q frame PROTOCOL processing layer which isn't bound to any
   particular network device driver.  For upper protocols also Linux
   VLAN code supplies an illusion of ethernet device per each VLAN
   sub-interface.

   Linux is slowly getting its network drivers capable to support 802.1q
   enlarged ethernet frames, but those are still few and far in between.

> Robert Cohen
> TLTSU, Australian National University.

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
