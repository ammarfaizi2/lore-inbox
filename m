Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVKJOBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVKJOBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVKJOBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:01:13 -0500
Received: from ns.suse.de ([195.135.220.2]:44237 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750891AbVKJOBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:01:12 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH 5/39] NLKD/x86-64 - early/late CPU up/down notification
Date: Thu, 10 Nov 2005 14:10:16 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F32.76F0.0078.0@novell.com>
In-Reply-To: <43720F32.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101410.16903.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 15:01, Jan Beulich wrote:
> x86_64-specific part of the new mechanism to allow debuggers to learn
> about starting/dying CPUs as early/late as possible.

Please just use the normal notifier chains instead (CPU_UP, CPU_DOWN, 
register_cpu_notifier). I don't see much sense to have two different 
mechanisms to do the same thing. While they might be not as early/late
as your mechanism I think the users of your debugger can tolerate that.

-Andi
