Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWH2Qll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWH2Qll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWH2Qlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:41:40 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:35229 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965100AbWH2Qlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:41:39 -0400
Date: Tue, 29 Aug 2006 18:30:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Dong Feng <middle.fengdong@gmail.com>, Andi Kleen <ak@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
In-Reply-To: <1156867503.2722.72.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0608291828540.8682@yvahk01.tjqt.qr>
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com> 
 <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr> 
 <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
 <1156867503.2722.72.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Sorry for my typo. I actually means "0-1G physical memory space." My
>> question is actually why there is a 3G offset from linear kernel to
>> physical kernel. Why not simply have kernel memory linear space
>> located on 0-1G linear address, and therefore the physical kernel and
>> linear kernel just coincide?
>
>the price for that would be that you would have to flush all the tlb's
>on each syscall. That's seen as a quite hefty price by many kernel
>developers.

Since it's all just virtual addresses, is the TLB flush really that much 
different when kernelspace runs from (virtual) 0x00000000-0x3FFFFFFF rather 
than (virtual)0xC000000-0xFFFFFFFF?


Jan Engelhardt
-- 
