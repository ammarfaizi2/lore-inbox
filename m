Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131257AbRAZOlZ>; Fri, 26 Jan 2001 09:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbRAZOlQ>; Fri, 26 Jan 2001 09:41:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18578 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131257AbRAZOlE>;
	Fri, 26 Jan 2001 09:41:04 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.35880.887884.1405@pizda.ninka.net>
Date: Fri, 26 Jan 2001 06:39:36 -0800 (PST)
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: James Sutherland <jas88@cam.ac.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <20010126151058.A6331@pcep-jamie.cern.ch>
In-Reply-To: <14961.24658.319734.448248@pizda.ninka.net>
	<Pine.SOL.4.21.0101261139150.15526-100000@orange.csi.cam.ac.uk>
	<14961.25754.449497.640325@pizda.ninka.net>
	<20010126151058.A6331@pcep-jamie.cern.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamie Lokier writes:
 > Ignore only _one_ RST frame (the first one)

Hmmm... let me say it for the hundreth time.

Valid RST frames cannot be ignored under any circumstances.
It is a full failure, period.

The RST frame does not indicate why it happened, so you may not intuit
the reason, "retry" the connection, or anything else like that.  It
means connection failed, and we must return error from connect().

Nothing else is acceptable.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
