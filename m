Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTKZNHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTKZNHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:07:20 -0500
Received: from sphere.barak.net.il ([212.150.48.98]:52626 "EHLO
	sphere.barak.net.il") by vger.kernel.org with ESMTP id S261909AbTKZNHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:07:18 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PG_reserved bug
Date: Wed, 26 Nov 2003 15:07:13 +0200
Organization: Montilio
Message-ID: <004501c3b41e$38b3c570$1d01a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <20031126125020.GL8039@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't I just not use the reserved bit (therefore effectively use the
refcount), and keep the minimal count at 1 or 2?  Will that have the same
effect as setting the reserved bit?

Amir.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of William Lee Irwin
III
Sent: Wednesday, November 26, 2003 2:50 PM
To: Amir Hermelin
Cc: linux-kernel@vger.kernel.org
Subject: Re: PG_reserved bug


On Wed, Nov 26, 2003 at 02:45:06PM +0200, Amir Hermelin wrote:
> Ok, fair enough.  According to what you say, this behavior won't 
> change in 2.6.  So, I'm still left with my second question: since I do 
> access the pages from several places in my module, and I want to use 
> the refcount field of the struct page (and not have to wrap the pages 
> in another structure) so I know when my page is no longer referenced, 
> how can I make sure it's 'safe' to not use the reserved bit?

It looks like you'll have to wrap the pages in another structure. The
refcounts for reserved pages are effectively meaningless.


-- wli
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


