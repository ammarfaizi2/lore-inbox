Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUJNKwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUJNKwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270024AbUJNKwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:52:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27265 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266680AbUJNKwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:52:42 -0400
To: Andi Kleen <ak@muc.de>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question about MTRR areas on x86_64
References: <2M5w2-y8-3@gated-at.bofh.it>
	<m3vfdox14o.fsf@averell.firstfloor.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2004 04:49:16 -0600
In-Reply-To: <m3vfdox14o.fsf@averell.firstfloor.org>
Message-ID: <m1acupefrn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> Markus Lidel <Markus.Lidel@shadowconnect.com> writes:
> >
> > Could it be because the machine has too much memory, or is there a bug in the
> I2O driver?
> 
> 
> The problem comes from the BIOS who set up reg00 to be overlapping
> over other areas. The Linux MTRR driver cannot deal with overlapping
> MTRRs, in fact it is sometimes impossible because it could run
> out of registers or violate some of the MTRR restrictions.

And the BIOS is using overlapping MTRRs because otherwise it would run
out.
 
> It's a long standing problem, eventual fix will be to get rid
> of MTRRs completely and only use PAT. But it needs a bit more work.


That would be nice to see.

Eric
