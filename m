Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVKJOYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVKJOYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVKJOYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:24:55 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40992
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750744AbVKJOYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:24:54 -0500
Message-Id: <4373667E.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 15:25:50 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 19/39] NLKD/x86-64 - stack-pointer-invalid markers
References: <43720DAE.76F0.0078.0@novell.com>  <4372120B.76F0.0078.0@novell.com>  <43721239.76F0.0078.0@novell.com> <200511101423.55768.ak@suse.de>
In-Reply-To: <200511101423.55768.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 10.11.05 14:23:55 >>>
>On Wednesday 09 November 2005 15:14, Jan Beulich wrote:
>> This adds static information about the code regions where the stack
>> pointer cannot be relied upon. Kernel debuggers may then use this
>> information to determine which stack to switch to when having a need
>> to switch off of namely the NMI stack.
>
>Hmm - can't this be expressed in CFI somehow? 

Probably one could use .cfi_undefined, but the code needing the information (switching away from the NMI stack) shouldn't have to go through parsing the .eh_frame section contents in order to obtain that information.

Jan

