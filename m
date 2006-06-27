Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWF0InS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWF0InS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWF0InS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:43:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:12211 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751104AbWF0InR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:43:17 -0400
To: lists@gammarayburst.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: ia32 binfmt problem with x86-64
References: <20060626112210.307DB1A04006@prtg1.pretago.de>
From: Andi Kleen <ak@suse.de>
Date: 27 Jun 2006 10:43:05 +0200
In-Reply-To: <20060626112210.307DB1A04006@prtg1.pretago.de>
Message-ID: <p73veqnt2ee.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lists@gammarayburst.de writes:
> 
> This all makes sense. But 64 bit and 32 bit apps should get the same
> treatment right?

No - i386 behaves different here than x86-64.

x86-64 always had NX/PROT_EXEC (although not all CPUs have always enforced it)
while i386 has lots of legacy binaries that don't know about it.

-Andi
