Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWAYPjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWAYPjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWAYPjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:39:15 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:30713 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751222AbWAYPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:39:14 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 16:38:13 +0100
To: tytso@mit.edu, froese@gmx.de
Cc: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <43D79B65.nailD78D400YY@burner>
References: <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner>
 <20060123203010.GB1820@merlin.emma.line.org>
 <1138092761.2977.32.camel@laptopd505.fenrus.org>
 <43D5EEA2.nailCE7111GPO@burner>
 <1138094141.2977.34.camel@laptopd505.fenrus.org>
 <20060124212843.GA15543@thunk.org>
 <20060125001955.3d11ff36.froese@gmx.de>
In-Reply-To: <20060125001955.3d11ff36.froese@gmx.de>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig <froese@gmx.de> wrote:

> Theodore Ts'o wrote:
> >
> > ... proposed a hack where mlockall() would adjust RLIMIT_MEMLOCK.
> > Yes, no question it's a hack and a special case; the question is
> > whether cure or the disease is worse.
>
> What about exec?  The memory locks are removed on exec but with that
> hack the raised limit would stay.  Looks like a security bug.

The RLIMIT_MEMLOCK feature itself may be a security bug implemented the way it 
currentlyy is.

For me it would make sense to be able to lock everything in core and then
be able to tell the system that at most 1MB of additional memory may be locked.

In this case, there should be no general failure but the possibility to
verify that the value is sufficient for usual cases.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
