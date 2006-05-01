Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWEARnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWEARnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWEARnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:43:03 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:51640 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932174AbWEARnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:43:00 -0400
Date: Mon, 1 May 2006 19:42:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4a/4] MultiAdmin LSM (LKCS'ed)
In-Reply-To: <20060501164740.GA8995@kroah.com>
Message-ID: <Pine.LNX.4.61.0605011941220.3919@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com>
 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
 <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
 <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0605011801400.32172@yvahk01.tjqt.qr> <20060501164740.GA8995@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>asm #include goes last.

How come?

>> +static inline int range_intersect_wrt(uid_t, uid_t, uid_t, uid_t);
>
>inline functions don't need definitions like this.

If memory serves right, callees mentioned below their callers need a 
prototype.

>> +static gid_t Supergid = -1, Subgid = -1;
>> +static uid_t Superuid_start = 0, Superuid_end = 0,
>> +    Subuid_start = -1, Subuid_end = -1,
>> +    Netuid = -1, Wrtuid_start = -1, Wrtuid_end = -1;
>> +static int Secondary = 0;
>
>Variables do not have capital letters.

Who has, besides macros, if anything?



Jan Engelhardt
-- 
