Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWHGPa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWHGPa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWHGPa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:30:56 -0400
Received: from mail.suse.de ([195.135.220.2]:22175 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932166AbWHGPaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:30:55 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: Double the per cpu area size
Date: Mon, 7 Aug 2006 17:30:47 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
References: <m1mzagfu03.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1mzagfu03.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071730.47120.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  
>  #include <asm/pda.h>
>  
> +#define PERCPU_ENOUGH_ROOM 65536

I would prefer if you didn't do that unconditionally. Can you make
it dependent on NR_IRQS or so?  Can you add a test for CONFIG_TINY
to make it smaller?

Also longer term it should really properly fixed

-Andi
