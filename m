Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRAYVDi>; Thu, 25 Jan 2001 16:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129334AbRAYVD2>; Thu, 25 Jan 2001 16:03:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33930 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129305AbRAYVDV>;
	Thu, 25 Jan 2001 16:03:21 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.37982.739742.487042@pizda.ninka.net>
Date: Thu, 25 Jan 2001 13:02:22 -0800 (PST)
To: Alexandre Hautequest <hquest@fesppr.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-random IP IDs
In-Reply-To: <980451650.3a7081428753c@webmail.fesppr.br>
In-Reply-To: <980451650.3a7081428753c@webmail.fesppr.br>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexandre Hautequest writes:
 > I was playing a bit on some of my machines with Nessus (www.nessus.org), and it
 > told me the following text:
 > 

Nessus is saying something bogus to you.

 > Is there some option to dinamically enable this random IP ID's, or I need to 
 > change something and recompile, or just "No way!"?

Ip IDs only matter when packets can be fragmented.  If the packet
cannot be fragmented, the Ip ID field serves no purpose.  Whatever the
nessus thing did to test this, it used a IP packet to/from the linux
box which had the "Don't Fragment" bit set in the IP header, which as
a consequence means the ID field is meaningless.

If the "don't fragment" bit were not set, and fragmentation was
possible, Linux will use a randomized ID field.  The nessus folks
need to fix their test.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
