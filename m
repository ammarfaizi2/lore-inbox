Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129291AbRB0ALX>; Mon, 26 Feb 2001 19:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129292AbRB0ALO>; Mon, 26 Feb 2001 19:11:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45215 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129291AbRB0ALE>;
	Mon, 26 Feb 2001 19:11:04 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.61250.224811.987948@pizda.ninka.net>
Date: Mon, 26 Feb 2001 16:05:22 -0800 (PST)
To: "Benjamin C.R. LaHaise" <blah@kvack.org>
Cc: michael@linuxmagic.com, Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, waltje@uWalt.NL.Mugnet.ORG
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
In-Reply-To: <Pine.LNX.3.96.1010226184514.9835E-100000@kanga.kvack.org>
In-Reply-To: <15002.58854.215318.882641@pizda.ninka.net>
	<Pine.LNX.3.96.1010226184514.9835E-100000@kanga.kvack.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin C.R. LaHaise writes:
 > Since the ip header fits in the cache of some CPUs (like the P4),
 > this becoming a cheaper operation than ever before.

At gigapacket rates, it becomes an issue.  This guy is talking about
tinkering with new IP _options_, not just the header.  So even if the
IP header itself fits totally in a cache line, the options afterwardsd
likely will not and thus require another cache miss.

Later,
David S. Miller
davem@redhat.com
