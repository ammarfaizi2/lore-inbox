Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVALWJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVALWJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVALWIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:08:34 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31172 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261468AbVALVyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:54:24 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20050112074906.GB5735@devserv.devel.redhat.com>
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	 <200501112251.j0BMp9iZ006964@localhost.localdomain>
	 <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>
	 <20050112074906.GB5735@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 16:12:45 -0500
Message-Id: <1105564365.3357.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-12 at 08:49 +0100, Arjan van de Ven wrote: 
> On Tue, Jan 11, 2005 at 07:43:29PM -0600, Jack O'Quin wrote:
> > > This is straying from the core issue...  But, Arjan's saying that an RT
> > > (non-root) task could trash the filesystem if it deadlocks the machine
> > > (because those important fs and IO threads don't run).
> > 
> > Lexicographic ambiguity: Lee and Paul are using "trash" for things
> > like installing a hidden suid root shell or co-opting sendmail into an
> > open spam relay.  Arjan just means crashing the system which forces
> > reboot to run fsck.
> 
> I actually meant data corruption.

OK, so the ability to run RT tasks implies the ability to possibly
corrupt data.  It appears that this can't be fixed until we have a real
isochronous scheduling class; for the forseeable future RT tasks will
need SCHED_FIFO and nonroot users will need to run them.

Anyway it's good to see the problem finally being taken seriously.

Lee

