Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbRAZBFg>; Thu, 25 Jan 2001 20:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132783AbRAZBF0>; Thu, 25 Jan 2001 20:05:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33420 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130335AbRAZBFR>;
	Thu, 25 Jan 2001 20:05:17 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.52503.383968.366586@pizda.ninka.net>
Date: Thu, 25 Jan 2001 17:04:23 -0800 (PST)
To: CaT <cat@zip.com.au>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
In-Reply-To: <20010126115057.A366@zip.com.au>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net>
	<200101251905.f0PJ5ZG216578@saturn.cs.uml.edu>
	<14960.31423.938042.486045@pizda.ninka.net>
	<20010125115214.D9992@draco.foogod.com>
	<m3itn3i5iu.fsf@austin.jhcloos.com>
	<14960.50897.494908.316057@pizda.ninka.net>
	<20010126115057.A366@zip.com.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CaT writes:
 > gozer:~# more /proc/sys/net/ipv4/tcp_ecn 
 > 1
 > 
 > and I can contact hotmail just fine.
 ...
 > where should I go to on hotmail to see it fail?

Try telnetting to port 25 on one of their
"*.hotmail.com" MX records.

For example:
? host -a hostmail.com
...
hostmail.com	651 IN	MX	10 mc6.law5.hotmail.com
...
mc6.law5.hotmail.com	383 IN	A	216.33.238.136
? telnet 216.33.238.136 25
Trying 216.33.238.136...
telnet: Unable to connect to remote host: Connection refused
?

Some of the MX records that show up for hotmail.com go
to different machines, such as INKY.SOLINUS.COM which seems
to let ECN connections through just fine.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
