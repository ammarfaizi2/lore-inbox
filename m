Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVBDBUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVBDBUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbVBDBTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:19:22 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:50770 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263098AbVBDA4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:56:38 -0500
Message-ID: <4202C839.8000103@yahoo.com.au>
Date: Fri, 04 Feb 2005 11:56:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?UTF-8?B?77+9?= <terje_fb@yahoo.no>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.10: kswapd spins like crazy
References: <20050203195033.29314.qmail@web51608.mail.yahoo.com> <4202BE05.9090901@yahoo.com.au>
In-Reply-To: <4202BE05.9090901@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------060502050903040208020601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060502050903040208020601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> Hmm, your DMA zone has no active pages, and pages_scanned (which 
> triggers all_unreclaimable)
> is only incremented when scanning the active list. But I wonder, if the 
> pages can't be
> freed, why aren't they being put on the active list?

Oh, attached should be a minimal fix if you would like to try it out.

--------------060502050903040208020601
Content-Type: text/plain;
 name="vmscan-minfix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="vmscan-minfix.patch"

CgoKLS0tCgogbGludXgtMi42LW5waWdnaW4vbW0vdm1zY2FuLmMgfCAgICAxICsKIDEgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLXB1TiBtbS92bXNjYW4uY352bXNj
YW4tbWluZml4IG1tL3Ztc2Nhbi5jCi0tLSBsaW51eC0yLjYvbW0vdm1zY2FuLmN+dm1zY2Fu
LW1pbmZpeAkyMDA1LTAyLTA0IDExOjUyOjM3LjAwMDAwMDAwMCArMTEwMAorKysgbGludXgt
Mi42LW5waWdnaW4vbW0vdm1zY2FuLmMJMjAwNS0wMi0wNCAxMTo1MzozMi4wMDAwMDAwMDAg
KzExMDAKQEAgLTU3NSw2ICs1NzUsNyBAQCBzdGF0aWMgdm9pZCBzaHJpbmtfY2FjaGUoc3Ry
dWN0IHpvbmUgKnpvCiAJCQlucl90YWtlbisrOwogCQl9CiAJCXpvbmUtPm5yX2luYWN0aXZl
IC09IG5yX3Rha2VuOworCQl6b25lLT5wYWdlc19zY2FubmVkICs9IG5yX3NjYW47CiAJCXNw
aW5fdW5sb2NrX2lycSgmem9uZS0+bHJ1X2xvY2spOwogCiAJCWlmIChucl90YWtlbiA9PSAw
KQoKXwo=
--------------060502050903040208020601--

