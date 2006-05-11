Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWEKKld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWEKKld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 06:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWEKKld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 06:41:33 -0400
Received: from mail.suse.de ([195.135.220.2]:25478 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030221AbWEKKlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 06:41:32 -0400
From: Andi Kleen <ak@suse.de>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Date: Thu, 11 May 2006 12:41:25 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060510203015.GA13949@elf.ucw.cz> <4463133A.8060806@argo.co.il>
In-Reply-To: <4463133A.8060806@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111241.26252.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 12:34, Avi Kivity wrote:
> Pavel Machek wrote:
> > Really? If someone does 
> >
> > 	if (something)
> > 		clearsegment(seg)
> > 	somethingelse();
> >
> > ... he'll get very confusing behaviour instead of compile error. 
> >
> > Okay, that's weaker argument than expected...
> >
> > Also clearsegment(x) clearsegment(y); will compile when it should not.
> >
> > Also clearsegment(i++) will behave strangely. So perhaps 
> >
> > #define clearsegment(seg) do { seg; } while (0)
> >   
> 
> static inline void clearsegment(int seg) {}


It's all mood because the complete function is wrongly named
and probably should just go.

-Andi
