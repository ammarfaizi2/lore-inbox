Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262974AbTDBMB0>; Wed, 2 Apr 2003 07:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbTDBMBZ>; Wed, 2 Apr 2003 07:01:25 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:49842 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262974AbTDBMBY>; Wed, 2 Apr 2003 07:01:24 -0500
Message-Id: <200304021211.h32CBkGi007395@locutus.cmf.nrl.navy.mil>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] second pass at fixing atm spinlock 
In-reply-to: Your message of "Wed, 02 Apr 2003 08:18:47 +0100."
             <20030402081847.A22335@infradead.org> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 02 Apr 2003 07:11:46 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030402081847.A22335@infradead.org>,Christoph Hellwig writes:
>You always include the he driver in your patches, what about cleaning it up
>and submitting it first?

it still has one serious (atleast in my opnion) bug.  the very first pdu
sent on any particular vpi/vci pair has a corrupted crc.  its during 
initialization somewhere that i dont get the crc 'counters' cleared.
