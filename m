Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132363AbRAZLwa>; Fri, 26 Jan 2001 06:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRAZLwT>; Fri, 26 Jan 2001 06:52:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56208 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129562AbRAZLwB>;
	Fri, 26 Jan 2001 06:52:01 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.25754.449497.640325@pizda.ninka.net>
Date: Fri, 26 Jan 2001 03:50:50 -0800 (PST)
To: James Sutherland <jas88@cam.ac.uk>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.SOL.4.21.0101261139150.15526-100000@orange.csi.cam.ac.uk>
In-Reply-To: <14961.24658.319734.448248@pizda.ninka.net>
	<Pine.SOL.4.21.0101261139150.15526-100000@orange.csi.cam.ac.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Sutherland writes:
 > A delayed retry without ECN might be a good compromise...
 > 
 > Every single connection to ECN-broken sites would work as normal - it
 > would just take an extra few seconds. Instead of "Hotmail doesn't
 > work!" it becomes "Hrm... Hotmail is fscking slow, but Yahoo is fine. I'll
 > use Yahoo". A few million of those, and suddenly Hotmail isn't so hot...

No, as explained in previous emails, no retry scheme can work.

Hotmails failing machines, for example, send RST packets back when
they see ECN.  Ignoring valid TCP RST frames is unacceptable and
Linux will not do that as long as I am maintaining it.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
