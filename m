Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUK2QCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUK2QCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUK2QCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:02:41 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:30134 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261745AbUK2P6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:58:24 -0500
In-Reply-To: <Pine.LNX.4.61.0411150735070.10262@hibernia.jakma.org>
Subject: Re: [patch 4/10] s390: network driver.
To: paul@clubi.ie
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF773C347F.92E998FA-ONC1256F5B.0056F87D-C1256F5B.0057A78F@de.ibm.com>
From: Thomas Spatzier <thomas.spatzier@de.ibm.com>
Date: Mon, 29 Nov 2004 16:57:25 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 29/11/2004 16:57:48
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> Using a socket per interface wont address problem of sending
> quite stale packets when a link > comes back after a long time
> down, AUI. (not a huge problem - but not nice).
>
> Jeff???

Has there been any outcome on the discussion about whether or not
a device driver should drop packets when the cable is disconnected?
It seems that from the zebra point of view, as Paul wrote,
it would be better to not block sockets by queueing up packets
when there is no cable connection.

I do also think that it does not make sense to keep packets in the
queue and then send those packets when the cable is plugged in
again after a possibly long time.
There are protocols like TCP that handle packet loss anyway.

Regards,
Thomas.

