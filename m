Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272697AbTG1HSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272701AbTG1HSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:18:42 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:27406 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S272697AbTG1HSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:18:41 -0400
Message-ID: <01a601c354da$9710cc10$cd01a8c0@llewella>
From: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
To: "Ben Greear" <greearb@candelatech.com>,
       "David S. Miller" <davem@redhat.com>,
       "Carlos Velasco" <carlosev@newipnet.com>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com> <20030727151234.6e2aa57e.davem@redhat.com> <3F248AE5.4000204@candelatech.com>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Mon, 28 Jul 2003 09:33:46 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> > Not a bug.  This behavior is on purpose.
First of all I'm sorry I rubbed some old sores. I didn't know the behaviour was on purpose, and I did google for it. Could have
saved my weekend, had I known.

> >Bas's problem can be solved by him giving a "preferred source"
> >to each of his IPV4 routes and setting the "arpfilter" sysctl
> >variable for his devices to "1".
>
> Yes, it's another approach to solve his problem. But he must play with routing.

Routing isn't solving anything here, it's too dynamic. Only one of the devices has a fixed IP, and handles a link to the outside,
among others. The other is on DHCP: addresses can change without warning. Both are on the same ethernet segment.

I've looked at the hidden patch, and it's capable of doing this right. I do think this has to be solved at the device layer. It's
quite counter intuitive the way it is now. My vote goes to hidden.

Regards,
Bas




