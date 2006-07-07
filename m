Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWGGILS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWGGILS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 04:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWGGILS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 04:11:18 -0400
Received: from ns.firmix.at ([62.141.48.66]:36738 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932069AbWGGILQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 04:11:16 -0400
Subject: Re: ext4 features
From: Bernd Petrovitsch <bernd@firmix.at>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Ric Wheeler <ric@emc.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44ADD223.9010005@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>
	 <20060705214133.GA28487@fieldses.org>  <44AC7647.2080005@tmr.com>
	 <1152189796.5689.17.camel@lade.trondhjem.org> <44ADC3CE.1030302@tmr.com>
	 <44ADCA0C.90401@emc.com> <1152240419.6092.16.camel@lade.trondhjem.org>
	 <44ADD223.9010005@tmr.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 07 Jul 2006 10:09:49 +0200
Message-Id: <1152259789.10641.7.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.354 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 23:16 -0400, Bill Davidsen wrote:
> Trond Myklebust wrote:
[...]
> >I repeat: you do _not_ need high res ctime/mtime updates in order to
> >figure out whether or not you need to do a daily backup on your file.
> >You do need it in order to figure out if the page you just read in from
> >your NFS server 2 microseconds ago is still valid.
> >
> In most cases you don't care and would be using locking if you did. The 
> old value was valid when you read it, the new value is valid, and if 
> data is changing in 2us and the change matters, you can't process the 
> data before it changes again (or at least may change).

Do you never use `make` on NFS-mounted filesystems (for e.g. kernel
compilation)?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

