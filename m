Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267483AbRGNAq6>; Fri, 13 Jul 2001 20:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbRGNAqs>; Fri, 13 Jul 2001 20:46:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9876 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267483AbRGNAqf>;
	Fri, 13 Jul 2001 20:46:35 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15183.38493.554937.379169@pizda.ninka.net>
Date: Fri, 13 Jul 2001 17:46:21 -0700 (PDT)
To: Chris Wedgwood <cw@f00f.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] VM statistics code
In-Reply-To: <20010714123141.A6119@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0107131946410.3892-100000@freak.distro.conectiva>
	<20010714123141.A6119@weta.f00f.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wedgwood writes:
 > On Fri, Jul 13, 2001 at 07:53:12PM -0300, Marcelo Tosatti wrote:
 > 
 >     Maybe. Personally I don't really care about the way we are doing
 >     this, as long as I can get the information. I can add /proc/vmstat
 >     easily if needed...
 > 
 > How about something under advance kernel hacking options of wherever
 > the sysrq options is? (and profiling used to live, before it was
 > always there), or, since the code is rather small, we could perhaps
 > always have this available.

I personally feel that it is imperative to have some kind of "lower
level" statistics available by default in the VM.  It would
undoubtedly save some head scratching for most bug reports.

We have all of this kind of stuff in the networking, because the SNMP
mibs require us to keep track of the information.  I can say for
certain that several bugs were found quickly because we were able to
notice anomalies in the events being triggered on the person's
machine.

There is a bit of a performance issue, since our VM is decently
threaded.  That can be solved with per-cpu statistics blocks like
the networking uses.

Later,
David S. Miller
davem@redhat.com
