Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbRGMIPJ>; Fri, 13 Jul 2001 04:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbRGMIO7>; Fri, 13 Jul 2001 04:14:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20365 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266958AbRGMIOm>;
	Fri, 13 Jul 2001 04:14:42 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15182.44527.926893.897932@pizda.ninka.net>
Date: Fri, 13 Jul 2001 01:14:39 -0700 (PDT)
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SOMAXCONN - bump up or sysctl?
In-Reply-To: <3B4E7EA1.F904DC43@sun.com>
In-Reply-To: <3B4E7EA1.F904DC43@sun.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim Hockin writes:
 > We have a request to bump up SOMAXCONN.  Are there are repurcussions to
 > doing so?  Would it be better to make it a sysctl?

There is a very serious repurcussion to allowing this be increased in
any form, people won't fix their code if you just give them this
bandaid.

The new connection backlog controlled by an upper limit of
SOMAXCONN is a "buffer" between the kernel and userspace.

It is _NOT_ a permanent storage area inside the kernel for new
connections.  Once people writing these apps start thinking about it
as a buffer (ie. think "temporary"), the thought to increase SOMAXCONN
will occur less often in their minds.

I have never been shown a legitimate argument for increasing
SOMAXCONN.

Later,
David S. Miller
davem@redhat.com
