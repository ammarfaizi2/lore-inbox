Return-Path: <linux-kernel-owner+w=401wt.eu-S1751636AbWLSNLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWLSNLW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 08:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWLSNLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 08:11:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53832 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbWLSNLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 08:11:21 -0500
Subject: Re: [patch 1/2] agpgart - allow user-populated memory types.
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>
Cc: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4587DF61.5020007@tungstengraphics.com>
References: <4579ADE3.6040609@tungstengraphics.com>
	 <1165616236.27217.108.camel@laptopd505.fenrus.org>
	 <1095.213.114.71.166.1165619148.squirrel@www.shipmail.org>
	 <1166518064.3365.1188.camel@laptopd505.fenrus.org>
	 <4587B47F.20008@tungstengraphics.com>
	 <1166530649.3365.1237.camel@laptopd505.fenrus.org>
	 <4587DF61.5020007@tungstengraphics.com>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Tue, 19 Dec 2006 14:11:17 +0100
Message-Id: <1166533877.3365.1244.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 13:47 +0100, Thomas Hellström wrote:
> Arjan van de Ven wrote:
> 
> >>A short background:
> >>The current code uses vmalloc only. The potential use of kmalloc was 
> >>introduced
> >>to save memory and cpu-speed.
> >>All agp drivers expect to see a single memory chunk, so I'm not sure we 
> >>want to have an array of pages. That may require rewriting a lot of code.
> >>    
> >>
> >
> >but if it's clearly the right thing.....
> >How hard can it be? there are what.. 5 or 6 AGP drivers in the kernel?
> >
> >
> >  
> >
> Hmm,
> but we would still waste a lot of memory compared to kmalloc,

surely it's at most 4Kb for the entire system?

(if agp allows the non-root user to pin a lot more than that in kernel
memory there is a different problem of rlimits ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

