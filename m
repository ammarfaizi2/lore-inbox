Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbTAJRlq>; Fri, 10 Jan 2003 12:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTAJRlq>; Fri, 10 Jan 2003 12:41:46 -0500
Received: from fmr02.intel.com ([192.55.52.25]:30955 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265681AbTAJRlo>; Fri, 10 Jan 2003 12:41:44 -0500
Message-ID: <A5974D8E5F98D511BB910002A50A66470580D523@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'James Bottomley'" <James.Bottomley@steeleye.com>, Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: RE: sd_read_cache_type 
Date: Fri, 10 Jan 2003 09:35:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


RE: cache
Yes, at least a synchronize, but can we always know (in time) if the medium
has been removed?  We may not always get an eject request, right?
I think write-back cache is inherently unsafe in general, but I guess we
have to allow unsafe things like that for non-production use.

Andy

-----Original Message-----
From: James Bottomley 
Sent: Friday, January 10, 2003 10:14 AM
[...]

Well, the cache is pretty often part of the permanent assembly, not part of 
the removable medium, so I think it should still be called for removable 
media. That begs the question, of course, what should the cache type be---it

strikes me as rather unsafe to have a removable RW medium with a write back 
cache?  I suppose at the very least we should to a SYNCHRONIZE on ejection
if 
it's write back?

James
[...]
