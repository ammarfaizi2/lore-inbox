Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVELMyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVELMyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVELMyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:54:32 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:38969
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261238AbVELMv7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:51:59 -0400
Message-Id: <s2835f7d.039@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 14:52:05 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH] adjust x86-64 watchdog tick calculation
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Get the x86-64 watchdog tick calculation into a state where it can also
>> be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
>> default (as is already done on i386).
>
>I already fixed this some time ago by using the same code as i386.
>
>That is what is in the current tree:
>        wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
>
>But I guess your version will work with a higher frequency, right?

For this part of the patch, yes, this will help with frequencies beyond 4GHz. The other change is which deals with nmi_hz being other than 1Hz.

Jan

