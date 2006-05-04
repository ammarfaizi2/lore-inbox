Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWEDH7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWEDH7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWEDH7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:59:30 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:19221
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750927AbWEDH7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:59:30 -0400
Message-Id: <4459D0C2.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 04 May 2006 10:00:34 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Tigran Aivazian" <tigran_aivazian@symantec.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix x86 microcode driver handling of multiple
	matching revisions
References: <444F9D34.76E4.0078.0@novell.com> <Pine.LNX.4.61.0605040828230.2440@ezer.homenet>
In-Reply-To: <Pine.LNX.4.61.0605040828230.2440@ezer.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran,

>First of all, I would like to know why is it that you have several chunks 
>in your microcode data which correspond to the same CPU? In the normal 
>data files which come from Intel there are no such chunks. Are you 
>concatenating the new files with the old (just in case the new update is 
>no good, so you can fall back to the old)?

the update file is the one in microcode_ctl-1.13. CPUID 0x00000f48 can
be found twice in that file, once with product code bits 0x0000005f and
a second time with 0x00000002. Obviously these overlap for CPUs with
product code 1 (testing bit mask 0x00000002), which is what is the case
for the (Paxville) system I saw the ill behavior on.

Thanks, Jan
