Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVEJPmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVEJPmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVEJPmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:42:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261689AbVEJPmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:42:05 -0400
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Eric Lammerts <eric@lammerts.org>, Markus Klotzbuecher <mk@creamnet.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1115738992.12402.10.camel@mindpipe>
References: <20050509183135.GB27743@mary>  <42804FA9.3020307@lammerts.org>
	 <1115738992.12402.10.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 10 May 2005 17:42:00 +0200
Message-Id: <1115739720.6008.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 11:29 -0400, Lee Revell wrote:
> On Tue, 2005-05-10 at 02:07 -0400, Eric Lammerts wrote:
> > Markus Klotzbuecher wrote:
> > > mini_fo is a virtual kernel filesystem that can make read-only file
> > > systems writable.
> > 
> > Nice.
> > 
> > Some remarks:
> > Some functions return -ENOTSUPP on error, which makes "ls -l" complain 
> > loudly when getxattr() fails. This should be -EOPNOTSUPP.
> > 
> > The module taints the kernel because of MODULE_LICENSE("LGPL").
> > Since all your copyright statements say it's GPL software, better change 
> > this to "GPL".
> 
> Ugh.  Why does an LGPL module taint the kernel again?

it's gpl anyway in practice when insmod'ed (LGPL mixed with GPL code
becomes GPL, as per the LGPL license)

you can say "GPL with additional rights" which would capture the spirit
of LGPL although the additional rights aren't really all that useful (eg
only for out-of-linux use)

