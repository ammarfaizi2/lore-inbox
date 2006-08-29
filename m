Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWH2OoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWH2OoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWH2OoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:44:16 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:60065 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965003AbWH2OoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:44:15 -0400
Date: Tue, 29 Aug 2006 16:36:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dong Feng <middle.fengdong@gmail.com>
cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
In-Reply-To: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The Linux kernel permenantly map 3-4G linear memory space to 0-4G
> physical memory space.

"3-4G linear memory space" is usually the "kernel space", i.e. 0xc0000000 
upwards. mostly the kernel is loaded here (on x86).

"0-4G physical memory space" denotes RAM. Since kernelspace is resident, it 
only seems logical to map it to 0G (that is, the start of RAM), because the 
end of RAM can be flexible.

IOW, you cannot map kernelspace to the physical location 0xc0000000 because 
there might not be that much RAM.

(Also note the PCI memory hole which is near the end of the 4G range.)

> My question is that what is the rationality
> behind this counterintuitive mapping. Is this just some personal
> choice for the earlier kernel developers?


Jan Engelhardt
-- 
