Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVELMsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVELMsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVELMsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:48:32 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14905
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261787AbVELMs3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:48:29 -0400
Message-Id: <s2835ea9.093@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 14:48:26 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <alexn@telia.com>
Cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH] adjust x86-64 watchdog tick calculation
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Alexander Nyberg <alexn@telia.com> 12.05.05 12:00:08 >>>
>tor 2005-05-12 klockan 10:27 +0200 skrev Jan Beulich:
>> Get the x86-64 watchdog tick calculation into a state where it can also
>> be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
>> default (as is already done on i386).
>
>Why shouldn't the watchdog be turned on by default? It's an extremely
>useful debugging aid and it's not like it fires NMIs often (the nmi_hz
>is far from reality).

For the so-called LAPIC one (based on performance monitor counters) that's true; that is for AMD boxes. For Intel boxes, which get defaulted to the IOAPIC version, it runs at HZ, and this is in my opinion significant overhead. If the Intel support for LAPIC watchdog was completed, and that used as the default, I would certainly agree to keeping it on by default.

Jan

