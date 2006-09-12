Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWILIJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWILIJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWILIJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:09:39 -0400
Received: from ns.suse.de ([195.135.220.2]:33748 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965136AbWILIJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:09:38 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] i386-pda: Initialize the PDA early, before any C code runs.
Date: Tue, 12 Sep 2006 08:44:44 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4505E8C1.7010906@goop.org>
In-Reply-To: <4505E8C1.7010906@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609120844.44564.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 00:52, Jeremy Fitzhardinge wrote:
> Initialize the PDA early, before any C code runs.
>
> This patch makes sure the PDA is usable in head.S, before any C code
> is run.
>
> On the boot CPU, this is done by using a temporary boot_pda which is
> initialized appropriately.  It is replaced with a proper PDA when the
> proper GDT is installed.
>
> For secondary CPUs, the GDT and PDA are pre-allocated and initialized.
> head.S just needs to set %gs and load the GDT.
>
> In the process, this removes the need for early_smp_processor_id() and
> early_current().

Against which tree was that? There are a zillion of rejects.

-Andi
