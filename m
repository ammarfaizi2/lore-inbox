Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVF1TpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVF1TpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVF1Tna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:43:30 -0400
Received: from mailfe02.tele2.fr ([212.247.154.44]:51100 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261198AbVF1Tlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:41:44 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Tue, 28 Jun 2005 21:41:28 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Robert Love <rml@novell.com>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628194128.GM4645@bouh.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Robert Love <rml@novell.com>, Andy Isaacson <adi@hexapodia.org>,
	linux-kernel@vger.kernel.org
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy> <20050628185300.GB30079@hexapodia.org> <1119986623.6745.10.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1119986623.6745.10.camel@betsy>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love, le Tue 28 Jun 2005 15:23:43 -0400, a écrit :
> I think we need to resolve the differences between the man pages,
> comments, expected user behavior, kernel implementation, POSIX standard,
> and what other OS's do.  Figure out what to do, then unify everything.

Well, posix says data should be kept. The solaris man page for madvise,
since it proposes a MADV_FREE case too do agree with posix.

I've tested the program (thanks Andy) on solaris 5.8, it does work fine.
On OSF1 it failed on the anonymous case.

Some people may want their data to be kept, so the safe side is to keep
data safe, i.e. both kernel and manpage be corrected, but leave a bug
notice in the manpage about previous kernels.

Regards,
Samuel
