Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTHYHt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 03:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTHYHt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 03:49:57 -0400
Received: from unthought.net ([212.97.129.24]:46263 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261221AbTHYHt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 03:49:56 -0400
Date: Mon, 25 Aug 2003 09:49:54 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030825074954.GC29987@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jamie Lokier <jamie@shareable.org>,
	Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
	jim.houston@ccur.com
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk> <20030825041423.GB29987@unthought.net> <20030825055028.GE20529@mail.jlokier.co.uk> <20030825062905.GA21262@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030825062905.GA21262@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 07:29:05AM +0100, Jamie Lokier wrote:
> Jamie Lokier wrote:
> > So that means the sysenter instruction _does_ exist on the PPro and
> > early Pentium II, but it isn't usable.
> 
> If anyone has information on what the SYSENTER and SYSEXIT
> instructions actually do on Intel Pentium Pro or stepping<3 Pentium II
> processors, I am very interested.

I dug up a little more from the archeological site (machine room -
sigh)...

-------------------------------------------
model name      : Pentium II (Deschutes)
stepping        : 2
$ ./syse 
Segmentation fault
-------------------------------------------
model name      : Celeron (Mendocino)
stepping        : 0
cpu MHz         : 334.097
$ ./syse
Segmentation fault
-------------------------------------------
CPU: Pentium II/Pentium II Xeon/Celeron (299.94-MHz 686-class CPU)
  Origin = "GenuineIntel"  Id = 0x651  Stepping = 1
$ ./syse
Bus error (core dumped)
-------------------------------------------

The last one is a FreeBSD box.


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
