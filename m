Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSLMKRZ>; Fri, 13 Dec 2002 05:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLMKRZ>; Fri, 13 Dec 2002 05:17:25 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:57099 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S261861AbSLMKRZ>;
	Fri, 13 Dec 2002 05:17:25 -0500
To: Aryix <aryix@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: another seagate for the black-list?
References: <courier.3DF9A5BB.00000AD0@softhome.net>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 13 Dec 2002 11:25:12 +0100
In-Reply-To: Aryix's message of "Thu, 12 Dec 2002 07:56:07 -0300"
Message-ID: <yw1xfzt2tdvb.fsf@tophat.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aryix <aryix@softhome.net> writes:

> hdparm say: max udma capable 2
> the disk is udma5

Which kernel version and IDE controller do you use?  The Promise
driver in 2.4.19 (at least) has a bug preventing anything above UMDA2.

The problem is that hwif->udma_four needs to be set to 1 in some init
function, I don't remember the name.  Would someone care to fix it?

-- 
Måns Rullgård
mru@users.sf.net
