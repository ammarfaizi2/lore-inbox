Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTEHTCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTEHTCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:02:44 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:64007 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262099AbTEHTCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:02:43 -0400
Date: Thu, 8 May 2003 20:15:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Shachar Shemesh <lkml@shemesh.biz>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>, D.A.Fedorov@inp.nsk.su,
       Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508201509.A19496@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Shachar Shemesh <lkml@shemesh.biz>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chuck Ebbert <76306.1226@compuserve.com>, D.A.Fedorov@inp.nsk.su,
	Steffen Persvold <sp@scali.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com> <1052398474.4849.57.camel@pc-16.office.scali.no> <20030508135839.A6698@infradead.org> <3EBAAB9D.5000508@shemesh.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EBAAB9D.5000508@shemesh.biz>; from lkml@shemesh.biz on Thu, May 08, 2003 at 10:10:21PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 10:10:21PM +0300, Shachar Shemesh wrote:
> Christoph Hellwig wrote:
> 
> >Maybe you have a different notion of proper mechanism then everyone
> >else.
> >
> Out of personal interest - would a mechanism that promised the following 
> be considered a "proper mechanism"?
> 1. Work on all platforms.
> 2. Allow load and unload in arbitrary order and timings (which also 
> means "be race free").
> 3. Have low/zero overhead if not used

No, the most important point is that a proper meachanism wouldn't
replace syscall slots but rather operate on kernel objects (file, inode
vma, task_struct, etc..).  Linus has expressed a few times that
he has no interest in loadable syscalls and any core developer I've
talked to agrees with that.

