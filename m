Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQKBX4W>; Thu, 2 Nov 2000 18:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129843AbQKBX4J>; Thu, 2 Nov 2000 18:56:09 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:57594 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129436AbQKBX4B>; Thu, 2 Nov 2000 18:56:01 -0500
Date: Thu, 02 Nov 2000 15:51:45 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: PATCH 2.4.0.10: Update hotplug
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <007401c04527$dc094510$6500000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="Windows-1252"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm glad to see the CardBus/PCI and network hotplug
support start happening!

Would you motivate two changes I noticed?

    - Changing /sbin/hotplug invocations ... now it can
      only support "add" and "del" events.  (USB now
      uses "add" and "remove", though "remove" doesn't
      try to do anything yet.)

      This removes the intended flexibility whereby
      different subsystems (such as networking) can
      define their own events.

    - "/sbin/hotplug net ..." replaced by "/sbin/network",
      with two custom event types.

The original intent of /sbin/hotplug was to centralize all
the hotplug-related dispatching, addressing both the module
selection/loading problem and device config/setup aspects
of device setup.

By creating another hotplug command (/sbin/network) you're
starting down what seems a slippery slope, where there's
no longer a single dispatch point to enable/disable or
to debug from.  Why discard the, err, "conceptual unity"
of one access point for usermode hotplug policy agents?

- Dave



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
