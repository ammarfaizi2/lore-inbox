Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbTCKQ1R>; Tue, 11 Mar 2003 11:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbTCKQ1R>; Tue, 11 Mar 2003 11:27:17 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:32281 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S262912AbTCKQ1Q>; Tue, 11 Mar 2003 11:27:16 -0500
Date: Tue, 11 Mar 2003 17:29:46 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <1047402060.19262.33.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0303111702170.13969-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Mar 2003, Alan Cox wrote:
> On Mon, 2003-03-10 at 07:22, Szakacsits Szabolcs wrote:
> > The question is if we want to support the buggy 2.9[56] compilers or
> > not. I checked Red Hat 7.3 and the latest errata gcc fixes this issue,
> > the generated code is ok. But your complier didn't and probably many
> > more out there don't.
>
> I don't think gcc 2.96 had that problem.

Randy's compliler is 2.96 and it forgot to do a 'sub $0xc,%esp'. See
yourself all the data at http://bugme.osdl.org/show_bug.cgi?id=432

Red Hat had this bug also for 1-1.5 year (there is a bugzilla entry
submitted by a Parasoft employee, the bug also screw[s|ed] user space
apps, e.g. by signal handling).

	Szaka

