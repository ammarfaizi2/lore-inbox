Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVDGMYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVDGMYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVDGMY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:24:29 -0400
Received: from upco.es ([130.206.70.227]:32457 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262445AbVDGMYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:24:19 -0400
Date: Thu, 7 Apr 2005 14:24:06 +0200
From: Romano Giannetti <romanol@upco.es>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Keith Owens <kaos@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2 in_atomic() picks up preempt_disable()
Message-ID: <20050407122406.GA16360@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Arjan van de Ven <arjan@infradead.org>, Keith Owens <kaos@sgi.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <13730.1112868613@kao2.melbourne.sgi.com> <1112869057.6290.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1112869057.6290.36.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 12:17:37PM +0200, Arjan van de Ven wrote:
> On Thu, 2005-04-07 at 20:10 +1000, Keith Owens wrote:
> > 2.6.12-rc2, with CONFIG_PREEMPT and CONFIG_PREEMPT_DEBUG.  The
> > in_atomic() macro thinks that preempt_disable() indicates an atomic
> > region so calls to __might_sleep() result in a stack trace.
> 
> but you're not allowed to schedule when preempt is disabled!
> 

Could it be related to this: 

http://marc.theaimsgroup.com/?l=linux-kernel&m=111277325629959&w=2



-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
