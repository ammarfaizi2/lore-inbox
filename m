Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVE2VQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVE2VQT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 17:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVE2VQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 17:16:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:35225 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261443AbVE2VQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 17:16:17 -0400
X-Authenticated: #428038
Date: Sun, 29 May 2005 23:16:10 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Greg Stark <gsstark@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matthias Andree <matthias.andree@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
Message-ID: <20050529211610.GA2105@merlin.emma.line.org>
Mail-Followup-To: Greg Stark <gsstark@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zmudycd1.fsf@stark.xeocode.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2005, Greg Stark wrote:

> Oracle, Sybase, Postgres, other databases have hard requirements. They
> guarantee that when they acknowledge a transaction commit the data has been
> written to non-volatile media and will be recoverable even in the face of a
> routine power loss.
> 
> They meet this requirement just fine on SCSI drives (where write caching
> generally ships disabled) and on any OS where fsync issues a cache flush. If

I don't know what facts "generally ships disabled" is based on, all of
the more recent SCSI drives (non SCA type though) I acquired came with
write cache enabled and some also with queue algorithm modifier set to 1.

> Worse, if the disk flushes the data to disk out of order it's quite
> likely the entire database will be corrupted on any simple power
> outage. I'm not clear whether that's the case for any common drives.

It's a matter of enforcing write order. In how far such ordering
constraints are propagated by file systems, VFS layer, down to the
hardware, is the grand question.

-- 
Matthias Andree
