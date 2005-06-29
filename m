Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVF2QoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVF2QoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVF2QoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:44:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:32466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262602AbVF2Qes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:34:48 -0400
Date: Wed, 29 Jun 2005 18:34:46 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Robert Love <rml@novell.com>
Cc: adi@hexapodia.org, samuel.thibault@ens-lyon.org,
       linux-kernel@vger.kernel.org, mtk-lists@gmx.net
MIME-Version: 1.0
References: <1119983300.6745.1.camel@betsy>
Subject: =?ISO-8859-1?Q?Re:_wrong_madvise(MADV_DONTNEED)_semantic?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <15933.1120062886@www35.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2005-06-28 at 11:16 -0700, Andy Isaacson wrote:
> 
> > Besides, if you read the documentation closely, it does not say what 
> > you
> > think it says.
> > 
> >        MADV_DONTNEED
> > 	      Do not expect access in the near future.  (For the time
> > 	      being, the application is finished with the given range,
> > 	      so the kernel can free resources associated with it.)
> > 	      Subsequent accesses of pages in this range will succeed,
> > 	      but will result either in reloading of the memory contents
> > 	      from the underlying mapped file (see mmap) or
> > 	      zero-fill-on-demand pages for mappings without an
> > 	      underlying file.
> > 
> > You seem to think that "reloading ... from the underlying mapped file"
> > means that changes are lost, but that's not implied.
> 
> This wording _does_ imply that changes are lost if the file is mapped
> writable and not mysnc'ed or if the memory mapping is anonymous.

A little late into this thread, but...

Indeed it does imply that, because that was what I understood
when (IIRC) I wrote that text in the man page.

> In the former, changes are dropped and the file is reread from the stale
> on-disk copy.  In the latter case, the data is dropped and the pages are
> zero-filled on access.

Yes.

Cheers,

Michael

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
