Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132279AbRDALES>; Sun, 1 Apr 2001 07:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132324AbRDALEI>; Sun, 1 Apr 2001 07:04:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50874 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132295AbRDALD4>;
	Sun, 1 Apr 2001 07:03:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15047.2789.738471.538915@pizda.ninka.net>
Date: Sun, 1 Apr 2001 04:03:01 -0700 (PDT)
To: Dan Hollis <goemon@anime.net>
Cc: Chip Salzenberg <chip@valinux.com>, <linux-kernel@vger.kernel.org>
Subject: Re: TCP Vegas implementation for Linux
In-Reply-To: <Pine.LNX.4.30.0104010352230.28774-100000@anime.net>
In-Reply-To: <E14jfEW-0007bT-00@tytlal>
	<Pine.LNX.4.30.0104010352230.28774-100000@anime.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Hollis writes:
 > tcp vegas performs very badly for me on asymmetric links (e.g. adsl),
 > about 50% performance loss vs non-vegas.

This among other reasons is why I ripped out vegas from the
kernel a couple years ago.  I'm actually disappointed vendors
have added this patch because it is still a reasearch problem
as to whether vegas's behavior negatively impacts the overall
internet when clients use it or not.

Sure it's sysctl controlled and disabled by default, but it really
should not be there at all as it's all too tempting to enable
this greedy behavior since it can in many cases improve performance
for the person using vegas (but not necessarily for other machines
not doing vegas but sharing the pipe with the vegas guys flows, they
can be negatively impacted).

Later,
David S. Miller
davem@redhat.com
