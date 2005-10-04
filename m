Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVJDPVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVJDPVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVJDPVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:21:04 -0400
Received: from mx1.suse.de ([195.135.220.2]:52385 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932353AbVJDPVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:21:00 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] x86_64 nmi_watchdog: Make check_nmi_watchdog static
Date: Tue, 4 Oct 2005 17:21:09 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
References: <m17jct8ggh.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m17jct8ggh.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041721.09736.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 17:11, Eric W. Biederman wrote:
> By using a late_initcall as i386 does we don't need to call
> check_nmi_watchdog manually after SMP startup, and we don't
> need different code paths for SMP and non SMP.
>
> This paves the way for moving apic initialization into init_IRQ,
> where it belongs.

I don't like it. I want to see a clear message in the log when
the NMI watchdog doesn't work and with your patch that comes too late.

-Andi (who has rejected similar patches before)

