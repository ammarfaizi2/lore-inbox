Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWEEHyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWEEHyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 03:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWEEHyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 03:54:23 -0400
Received: from blaster.systems.pipex.net ([62.241.163.7]:5315 "EHLO
	blaster.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1030337AbWEEHyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 03:54:23 -0400
Date: Fri, 5 May 2006 08:55:06 +0100 (BST)
From: Tigran Aivazian <tigran_aivazian@symantec.com>
X-X-Sender: tigran@ezer.homenet
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix x86 microcode driver handling of multiple matching
 revisions
In-Reply-To: <4459D0C2.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.61.0605050853370.2558@ezer.homenet>
References: <444F9D34.76E4.0078.0@novell.com> <Pine.LNX.4.61.0605040828230.2440@ezer.homenet>
 <4459D0C2.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006, Jan Beulich wrote:
> the update file is the one in microcode_ctl-1.13. CPUID 0x00000f48 can
> be found twice in that file, once with product code bits 0x0000005f and
> a second time with 0x00000002. Obviously these overlap for CPUs with
> product code 1 (testing bit mask 0x00000002), which is what is the case
> for the (Paxville) system I saw the ill behavior on.

Ok, in that case, yes, I agree that the driver should be corrected to deal 
with multiple chunks.

Kind regards
Tigran
