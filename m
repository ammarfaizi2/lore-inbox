Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTENS4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTENS4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:56:37 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:63255 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263631AbTENSz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:55:27 -0400
Date: Wed, 14 May 2003 14:07:45 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@digeo.com>
cc: mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <127820000.1052939265@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0305141503010.10617-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0305141503010.10617-100000@chimarrao.boston.redha
 t.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, May 14, 2003 15:04:55 -0400 Rik van Riel <riel@redhat.com>
wrote:

>> Not to mention they could end up being outside of any VMA,
>> meaning there's no sane way to deal with them.
> 
> I hate to follow up to my own email, but the fact that
> they're not in any VMA could mean we leak these pages
> at exit() time.

Well, they are still inside the vma.  Truncate doesn't shrink the vma.  It
just generates SIGBUS when the app tries to fault the pages in.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

