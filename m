Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTDKTud (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTDKTud (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:50:33 -0400
Received: from fmr02.intel.com ([192.55.52.25]:44283 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261684AbTDKTuc convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 15:50:32 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAA25@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Valdis.Kletnieks@vt.edu'" <Valdis.Kletnieks@vt.edu>,
       "'Shaya Potter'" <spotter@cs.columbia.edu>
Cc: "'John Bradford'" <john@grabjohn.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
       "'Frank Davis'" <fdavis@si.rr.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: kernel support for non-english user messages 
Date: Fri, 11 Apr 2003 13:02:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 3) Version a 500 megabyte file.  Change one block.  Do it a few more
times.
> Are you better off copying the whole file (which bloats your disk usage
and
> kills your I/O bandwidth), or keeping deltas (the list of allocated blocks
could be
> almost identical except for the replaced/rewritten blocks).  However, this
DOES
> make doing an fsck() a *lot* more interesting - is a block allocated to
multiple
> files in error or not?

For this I would yield to a mechanism similar to COW, block you modify,
block you copy ... it would impose some restrictions here and there, 
but it'd work, I'd say - still it is fun for fsck(), as you are changing
some semantics, but it'd be interesting.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
