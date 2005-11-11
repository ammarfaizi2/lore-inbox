Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVKKPfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVKKPfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVKKPfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:35:04 -0500
Received: from ns.suse.de ([195.135.220.2]:29877 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750818AbVKKPfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:35:01 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] x86-64: adjust ia32entry.S
Date: Fri, 11 Nov 2005 16:34:44 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <4370AFF0.76F0.0078.0@novell.com> <4370C36D.76F0.0078.0@novell.com> <43722D73.76F0.0078.0@novell.com>
In-Reply-To: <43722D73.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111634.44871.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 17:10, Jan Beulich wrote:
> IA32 compatibility entry points needlessly played with extended
> registers. Additionally, frame unwind information was still incorrect
> for ia32_ptregs_common (sorry, my fault).

What do you mean with needlessly played? That it didn't initialize 
all on the stack frame? That was more a feature than a bug.
Did it cause you problems?

In general I'm weary of making the asm macros more complex
(adding more arguments etc.) Please keep it simple.

-Andi
