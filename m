Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161581AbWHDXik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161581AbWHDXik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161582AbWHDXik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:38:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161581AbWHDXik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:38:40 -0400
Date: Fri, 4 Aug 2006 19:38:15 -0400
From: Dave Jones <davej@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060804233815.GG18792@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@in.ibm.com,
	fastboot@osdl.org, linux-kernel@vger.kernel.org,
	Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com> <m1k65onleq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k65onleq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 05:14:37PM -0600, Eric W. Biederman wrote:

 > I guess the practical question is do people see a real performance benefit
 > when loading the kernel at 4MB?

Linus claimed lmbench saw some huge wins. Others showed that for eg,
a kernel compile took the same amount of time, so take from that what you will..

 > Possibly the right solution is to do like I did on x86_64 and simply remove
 > CONFIG_PHYSICAL_START, and always place the kernel at 4MB, or something like
 > that.
 > 
 > The practical question is what to do to keep the complexity from spinning
 > out of control.  Removing CONFIG_PHYSICAL_START would seriously help with
 > that.

Given the two primary uses of that option right now are a) the aforementioned
perf win and b) building kexec kernels, I doubt anyone would miss it once
we go relocatable ;-)

		Dave

-- 
http://www.codemonkey.org.uk
