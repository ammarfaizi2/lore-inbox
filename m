Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWIAIaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWIAIaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWIAIaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:30:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33729 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964897AbWIAIaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:30:20 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/8] Implement per-processor data areas for i386.
Date: Fri, 1 Sep 2006 10:30:06 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060901064718.918494029@goop.org> <200609011016.45600.ak@suse.de> <44F7EEA2.3090600@goop.org>
In-Reply-To: <44F7EEA2.3090600@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609011030.06859.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 10:26, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > I applied it now, with one change. I replaced the %Ps with %cs because
> > that is apparently the more official way to do that in gcc. Please
> > change that in your copy too.
> >   
> 
> Do you mean the %P0, etc in the asms?

Yes.

> > There unfortunately were still quite a lot of rejects because -mm* 
> > is too different from mainline, but I fixed them all.
> >   
> Thanks.  Were there more conflicts than entry.S?

Yes ptrace-abi.h doesn't exist and the ""s in the Subject of your last patch caused 
quilt to freak out. I think there was one other too.

I hope everything still works. At least one of my test machines 
is currently completely unhappy on i386 with random hangs (even before 
your patches), still bisecting it.

-Andi
     
