Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285944AbRLYXMJ>; Tue, 25 Dec 2001 18:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285965AbRLYXL7>; Tue, 25 Dec 2001 18:11:59 -0500
Received: from ppp73-2-69.miem.edu.ru ([194.226.32.69]:6404 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S285944AbRLYXLv>;
	Tue, 25 Dec 2001 18:11:51 -0500
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [CFT] error checking for VM86 instruction emulation
Date: Wed, 26 Dec 2001 01:58:23 +0300
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <3C28C8C5.29C433ED@colorfullife.com>
In-Reply-To: <3C28C8C5.29C433ED@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01122602043800.01135@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> The emulation code for the instructions that cannot be executed in vm86
> mode directly (iretd, pushf and a few others) accesses user space memory
> without an exception handler. This can cause a kernel oops if the stack
> pointer points to non-present or read-only memory areas.
> 
> The attached patch adds these handlers, but I can't test them properly.
> Under 2.5.2-pre1, dosemu still runs.
> 
> The patch applies to both 2.4.17 and 2.2.20. Please test it.
It works. The Oops is no longer reproduceable at all (it was 100% reproduceable
before) so I vote for integrating this patch into kernel:)

Thank you.
