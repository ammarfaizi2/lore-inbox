Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVKJOG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVKJOG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVKJOG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:06:56 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:23069
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750911AbVKJOGz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:06:55 -0500
Message-Id: <4373624A.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 15:07:54 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 20/39] NLKD/x86-64 - switch_to() floating point
	adjustment
References: <43720DAE.76F0.0078.0@novell.com>  <43721239.76F0.0078.0@novell.com>  <4372127F.76F0.0078.0@novell.com> <200511101424.53484.ak@suse.de>
In-Reply-To: <200511101424.53484.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 10.11.05 14:24:53 >>>
>On Wednesday 09 November 2005 15:15, Jan Beulich wrote:
>> Touching of the floating point state in a kernel debugger must be
>> NMI-safe, specifically math_state_restore() must be able to deal with
>> being called out of an NMI context. In order to do that reliably, the
>> context switch code must take care to not leave a window open where
>> the current task's TS_USEDFPU flag and CR0.TS could get out of sync.
>
>Didn't we agree earlier on moving unlazy_fpu() down instead? 

I wasn't sure about that, and hence I submitted it the way I had coded it.

Jan

