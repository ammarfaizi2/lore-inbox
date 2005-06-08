Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVFHLzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVFHLzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVFHLzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:55:55 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:50076 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262178AbVFHLzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:55:48 -0400
Subject: Re: race in usbnet.c in full RT
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Brownell <david-b@pacbell.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <emints@ru.mvista.com>
In-Reply-To: <20050608103440.GA18380@elte.hu>
References: <42A6C6B3.2000303@ru.mvista.com>
	 <20050608103440.GA18380@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 08 Jun 2005 07:55:26 -0400
Message-Id: <1118231726.8255.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 12:34 +0200, Ingo Molnar wrote:
> * Eugeny S. Mints <emints@ru.mvista.com> wrote:
> 
> > seems there is a race in drivers/net/usbnet.c in full RT mode. To be 
> > honest I haven't hardly checked this on the latest kernel and latest 
> > RT patch but just took a look at usbnet.c and latest RT patch and 
> > haven't observed any related changes.
> 
> thanks, i've applied your patch to my tree. Note that your patch is 
> specific to the -RT kernel (both in terms of semantics and in term of 
> API dependence), so it does not make any sense to apply it upstream.  
> David, please ignore it.
> 

Is this action only take place on the same CPU, or is this also an SMP
problem?  I would think if this is a race with full RT, that this may
also be a race with SMP, unless the race is guaranteed to always happen
on the same CPU. Then this is only a RT problem.

-- Steve


