Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbTCTUuC>; Thu, 20 Mar 2003 15:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTCTUuC>; Thu, 20 Mar 2003 15:50:02 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:46854 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261876AbTCTUuB>; Thu, 20 Mar 2003 15:50:01 -0500
Date: Thu, 20 Mar 2003 22:00:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: akpm@digeo.com, <Joel.Becker@oracle.com>,
       <andrey@eccentric.mae.cornell.edu>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: major/minor split
In-Reply-To: <UTC200303192140.h2JLeF924104.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303202146100.12110-100000@serv>
References: <UTC200303192140.h2JLeF924104.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> (I hope the purpose of distinguishing arithmetic types dev_t
> and kdev_t is clear. The latter is simple e.g. 13+19.
> mk_kdev, major, minor are simple macros. Kernel use is fast,
> no conditional involved.
> The former must be backwards compatible, so MKDEV, MAJOR, MINOR
> are somewhat complicated macros; for example MAJOR asks: does it fit
> in 16 bits? then MAJOR is the first 8; otherwise MAJOR is
> the first DEV_MAJOR_BITS. Used only when converting from userspace.)

There is a point I'd like to get clear: where should the 16bit<->32bit 
dev_t conversion happen?
I think any software that cares about this should be safe by now. That 
leaves us with on-disk and on-wire formats and IMO only at these places a 
conversion should happen.
The other problem is how can software create nodes for a specific device?

bye, Roman

