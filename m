Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRCNCIF>; Tue, 13 Mar 2001 21:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131278AbRCNCH4>; Tue, 13 Mar 2001 21:07:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24712 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131270AbRCNCHj>;
	Tue, 13 Mar 2001 21:07:39 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15022.53815.129522.746120@pizda.ninka.net>
Date: Tue, 13 Mar 2001 18:06:47 -0800 (PST)
To: Jeffrey Butler <jeffreymbutler@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poll() behaves differently in Linux 2.4.1 vs. Linux 2.2.14 (POLLHUP)
In-Reply-To: <20010314015921.19287.qmail@web11808.mail.yahoo.com>
In-Reply-To: <20010314015921.19287.qmail@web11808.mail.yahoo.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeffrey Butler writes:
 >   I've noticed that poll() calls on IPv4 sockets do
 > not behave the same under linux 2.4 vs. linux 2.2.14. 
 > Linux 2.4 will return POLLHUP for a socket that is not
 > connected (and has never been connected) while Linux
 > 2.2 will not.
 >   The following example program demonstrates the
 > problem when it's run under linux 2.4:

True, this behavior was changed from 2.2.x.  We now match the behavior
of other svr4 systems, in particular Solaris.  This new behavior in
2.4.x will not change.

Later,
David S. Miller
davem@redhat.com
