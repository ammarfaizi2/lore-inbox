Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVDHXEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVDHXEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDHXEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:04:09 -0400
Received: from mail.dif.dk ([193.138.115.101]:25228 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261185AbVDHXEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:04:05 -0400
Date: Sat, 9 Apr 2005 01:06:37 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Steve French <smfrench@austin.rr.com>, Steven French <sfrench@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cifs: cleanup asn1.c - kfree
In-Reply-To: <20050407220622.GE4325@stusta.de>
Message-ID: <Pine.LNX.4.62.0504090105170.2455@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504042300520.2496@dragon.hyggekrogen.localhost>
 <20050407220622.GE4325@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Adrian Bunk wrote:

> On Mon, Apr 04, 2005 at 11:01:45PM +0200, Jesper Juhl wrote:
> > Remove redundant NULL pointer check before calling kfree().
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > 
> > 
> > --- linux-2.6.12-rc1-mm4/fs/cifs/asn1.c.with_patch1	2005-04-04 22:25:50.000000000 +0200
> > +++ linux-2.6.12-rc1-mm4/fs/cifs/asn1.c	2005-04-04 22:33:34.000000000 +0200
> > @@ -540,7 +540,6 @@ int decode_negTokenInit(unsigned char *s
> >  					   *(oid + 3)));
> >  					rc = compare_oid(oid, oidlen, NTLMSSP_OID,
> >  						 NTLMSSP_OID_LEN);
> > -					if(oid)
> >  						kfree(oid);
> >  					if (rc)
> >  						use_ntlmssp = TRUE;
> 
> 
> Please fix the indentation of the kfree after removing the if.
> 
I do, in the next patch in the series, the 
"fs_cifs_asn1-spacing-and-long-lines.patch" patch. That one fixes the 
indentation along with lots of other whitespace issues.


-- 
Jesper Juhl


