Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVGSUMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVGSUMF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVGSUME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:12:04 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:37030 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261636AbVGSULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:11:32 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: Noob question. Why is the for-pentium4 kernel built with 	-march=i686 ?
To: ivan@yosifov.net, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 19 Jul 2005 22:12:24 +0200
References: <4s3M3-ph-15@gated-at.bofh.it> <4s4y2-Rt-17@gated-at.bofh.it> <4s5aD-1sw-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DuyS0-00013Z-VG@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Yosifov <ivan@yosifov.net> wrote:

> -march implies -mtune and also implies thing like -msse2 for the
> instruction set where applicable.
> I think -march=pentium4 is equivalent to -mmmx -msse -msse2
> -mtune=pentium4 ( if I have not fogotten anything ).
> Pentium4 supports things like sse2 and mmx which AFAIK plain i686 does
> not.

AFAIK it's not possible to use SSE and MME in kernel mode, since these
registers aren't preserved (it would be expensive).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
