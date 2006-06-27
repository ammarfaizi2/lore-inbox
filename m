Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWF0TDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWF0TDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWF0TDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:03:15 -0400
Received: from mx1.pretago.de ([89.110.132.150]:9941 "EHLO mx1.pretago.de")
	by vger.kernel.org with ESMTP id S932530AbWF0TDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:03:14 -0400
From: Markus Schoder <lists@gammarayburst.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: ia32 binfmt problem with x86-64
Date: Tue, 27 Jun 2006 21:03:10 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626112210.307DB1A04006@prtg1.pretago.de> <p73veqnt2ee.fsf@verdi.suse.de>
In-Reply-To: <p73veqnt2ee.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606272103.10378.lists@gammarayburst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 10:43, Andi Kleen wrote:
> lists@gammarayburst.de writes:
> > 
> > This all makes sense. But 64 bit and 32 bit apps should get the same
> > treatment right?
> 
> No - i386 behaves different here than x86-64.
> 
> x86-64 always had NX/PROT_EXEC (although not all CPUs have always enforced it)
> while i386 has lots of legacy binaries that don't know about it.

But then 32 bit apps should be handled in a less restrictive fashion
than 64 bit apps, no? And also probably only for binaries that do
not have the exec_stack flag at all.

What I fail to understand then is why a 64 bit application with the
exec_stack flag set gets read_implies_exec and a 32 bit application
also with the exec_stack flag set does not (this is also the only case
where the behavior differs).

--
Markus
