Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVKJOBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVKJOBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVKJOBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:01:17 -0500
Received: from ns1.suse.de ([195.135.220.2]:45517 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750893AbVKJOBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:01:14 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH 20/39] NLKD/x86-64 - switch_to() floating point adjustment
Date: Thu, 10 Nov 2005 14:24:53 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <43721239.76F0.0078.0@novell.com> <4372127F.76F0.0078.0@novell.com>
In-Reply-To: <4372127F.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101424.53484.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 15:15, Jan Beulich wrote:
> Touching of the floating point state in a kernel debugger must be
> NMI-safe, specifically math_state_restore() must be able to deal with
> being called out of an NMI context. In order to do that reliably, the
> context switch code must take care to not leave a window open where
> the current task's TS_USEDFPU flag and CR0.TS could get out of sync.

Didn't we agree earlier on moving unlazy_fpu() down instead? 

-Andi
