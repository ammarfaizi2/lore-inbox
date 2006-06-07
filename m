Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWFGIub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWFGIub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWFGIua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:50:30 -0400
Received: from ns.firmix.at ([62.141.48.66]:13974 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751130AbWFGIua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:50:30 -0400
Subject: Re: Quick close of all the open files.
From: Bernd Petrovitsch <bernd@firmix.at>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3faf05680606061822g25c242ddq58efdb762ca33252@mail.gmail.com>
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com>
	 <200606062156.k56LuWFD001871@turing-police.cc.vt.edu>
	 <3faf05680606061502q28501343yb3a91dbda3c423b6@mail.gmail.com>
	 <200606070033.k570X6Bu007481@turing-police.cc.vt.edu>
	 <3faf05680606061822g25c242ddq58efdb762ca33252@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 07 Jun 2006 10:50:23 +0200
Message-Id: <1149670223.23078.5.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.319 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 06:52 +0530, vamsi krishna wrote:
[...]
> > > I checked as follows I did printf("lowest fd = %d",fileno(tmpfile()));
> > > it prints 3
>
> > Which proves that file descriptor 3 was closed, so tmpfile() was able to
> > open it.  This certainly implies that fd 0, 1, 2 (connected to stdin,
> > stdout, and stderr streams of stdio) are still open, contrary to your
> > statement that *all* of them are closed.

And it specifically says absolutely nothing about the file descriptors 4
and larger since open(2) always uses the lowest unused file descriptor.

> I know 0,1,2 are open (I opened it) no need to tell it specifically,
> HOW DO YOU THINK I CAN PRINT SOME THING WITHOUT OPENING THIS
> FILES(stdout,stderr)?

No reason to shout: The trivial solution is to syslog(3) the output like
all of the daemons out there do since ages.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

