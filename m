Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVKHRJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVKHRJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVKHRJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:09:36 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:35939
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030262AbVKHRJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:09:35 -0500
Message-Id: <4370EA15.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 18:10:29 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: stand-alone CONFIG_PAE
References: <4370AEE1.76F0.0078.0@novell.com>  <4370E69F.76F0.0078.0@novell.com> <20051108170243.GA3847@stusta.de>
In-Reply-To: <20051108170243.GA3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Adrian Bunk <bunk@stusta.de> 08.11.05 18:02:43 >>>
>On Tue, Nov 08, 2005 at 05:55:43PM +0100, Jan Beulich wrote:
>>...
>> Also appropriately qualify both options depending on configured
>> minimum processor type.
>
>With the current semantics of the cpu options this is wrong:
>M386 is a synonym for "kernel runs on all cpus".

No. Such a kernel in fact doesn't run on all CPUs. It's not like it can
take advantage of PAE if it's there, it'll die if there is no PAE.
That's why those that clearly can't have PAE have been excluded.

Jan
