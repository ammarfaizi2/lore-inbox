Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUEZNbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUEZNbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265688AbUEZNbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:31:39 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:50620 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265588AbUEZNW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:22:56 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: <root@chaos.analogic.com>
Cc: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>,
       <orders@nodivisions.com>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 06:25:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <Pine.LNX.4.53.0405260813440.858@chaos>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDHgs/UulS/VqlT2SiycbEmdPK5gAA/wTg
Message-Id: <S265588AbUEZNW4/20040526132827Z+2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Gentlemen,

> There is not enough RAM address-space in even 64-bit machines
> to do a sort/merge of even a typical inventory with all the
> keys present in RAM. So you need multiple tasks, each with
> as much of the 64-bit address-space occupied by RAM, as
> possible. Even then, you need to do partial sorts, etc.

Ironically, a fortune 500 company I left very recently is famous for their
inventory system that has been implemented in the last three years. If
someone were to assume I am exaggerating, a search for my name in google
groups would likely reveal what company that is, and looking up news about
their at finance.yahoo.com would likely churn up a few articles about the
adda-boys they have received for their inventory system and what it has done
for the company. 

I was the primary system admin/engineer for this system and it only occupied
roughly 1TB in a single database instance. 1TB would certainly fit in a
64-bit address space. While they didn't have a zillion sku's like a company
like Walmart would, their skus change on a regular basis and change at the
store level while information about a jar of mayonnaise or a desk in most
companies can stay quite static. Where I am going with this is I doubt there
are many inventory systems out there that run much in excess of a few
Terabytes.


> It's not "bloat-ware" that requires getting as much free RAM
> as possible for an application, but the business of doing business.
> So, performance of data-intensive work such as the sort/merge
> is improved by writing the contents of sleeping tasks RAM to
> a storage device and using that RAM. It's just that simple.

Again, my expectation is that most large database instances out there will
happily fit in a 64-bit address space. Ironically, while code tends to run
slower on 64-bit architectures because of reasons like having half as many
cache lines because of the larger word size, byte packing, etc.. The ability
to do a hash join in memory of two insanely large tables that wouldn't fit
into a 32-bit address space easily negates this small issue. So in that
regard, a 64-bit address space results in a performance boost provided the
DBA knows how to leverage the features.

--Buddy

