Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268050AbUH2QBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268050AbUH2QBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUH2QBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:01:16 -0400
Received: from opus.cs.columbia.edu ([128.59.20.100]:8945 "EHLO
	opus.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S268050AbUH2QBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:01:13 -0400
Subject: Re: silent semantic changes with reiser4
From: Shaya Potter <spotter@cs.columbia.edu>
To: Alex Zarochentsev <zam@namesys.com>
Cc: Jamie Lokier <jamie@shareable.org>, Christophe Saout <christophe@saout.de>,
       Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040829123428.GP5108@backtop.namesys.com>
References: <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
	 <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826001152.GB23423@mail.shareable.org>
	 <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com>
	 <20040826140500.GA29965@fs.tum.de>
	 <1093530313.11694.56.camel@leto.cs.pocnet.net>
	 <20040826150434.GF5733@mail.shareable.org>
	 <20040829123428.GP5108@backtop.namesys.com>
Content-Type: text/plain
Date: Sun, 29 Aug 2004 08:52:46 -0700
Message-Id: <1093794766.9102.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.6.1.106153, Antispam-Core: 4.6.1.104326, Antispam-Data: 2004.8.28.111534
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__TO_MALFORMED_2 0, __IN_REP_TO 0, __REFERENCES 0, __CT_TEXT_PLAIN 0, __CT 0, __HAS_MSGID 0, __SANE_MSGID 0, __MIME_VERSION 0, __HAS_X_MAILER 0, __CTE 0, EMAIL_ATTRIBUTION 0, QUOTED_EMAIL_TEXT 0, __MIME_TEXT_ONLY 0, REFERENCES 0.000, IN_REP_TO 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 16:34 +0400, Alex Zarochentsev wrote:

> Do you mean COW files or some another thing?  For COW files, the reiser4
> support is not enough, we need to teach cp(1) or another utility to inform the
> fs layer that copying can be done by creation of COW files.

it's easy enough to add that via an fs ioctl(), I did the equivalent
last semester for some research I'm doing while using ext3cow (which
unfortunately was put on hold for the summer), it's just a take off of
sys_link(), a sys_cowpy() of sorts.


