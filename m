Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUDHSw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUDHSw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:52:57 -0400
Received: from waste.org ([209.173.204.2]:44986 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262271AbUDHSwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:52:47 -0400
Date: Thu, 8 Apr 2004 13:52:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       celinux-dev@tree.celinuxforum.org
Subject: Re: 2.6.5-rc1-tiny1 for small systems
Message-ID: <20040408185222.GB6248@waste.org>
References: <20040316222548.GD11010@waste.org> <20040407164035.GT6248@waste.org> <200404072109.50466.vda@port.imtp.ilyichevsk.odessa.ua> <200404082142.28409.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404082142.28409.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 09:42:28PM +0300, Denis Vlasenko wrote:
> On Wednesday 07 April 2004 21:11, Denis Vlasenko wrote:
> > > > Originally I wanted to have CONFIG_MEASURE_INLINES=y,
> > > > but it died even earlier, looks like my gcc does not like
> > > > the fact that there is way too many warnings for
> > > > eisa-bus.c.
> > >
> > > Hmm, that's interesting. The measure inlines stuff works by generating
> > > warnings, but I have yet to see recent GCC quit after too many warnings.
> >
> > Well, trust me, it really did that. I do not eat magic mushrooms ;)
> > What gcc do you use? Can you try it with my config?
> 
> linux-2.6.5-tiny/drivers/eisa/Makefile
> ======================================
> # Makefile for the Linux device tree
> 
> # Being anal sometimes saves a crash/reboot cycle... ;-)
> EXTRA_CFLAGS    := -Werror

Ahh, that explains it. Thanks for the legwork. 

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
