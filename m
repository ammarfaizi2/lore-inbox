Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSDSSAf>; Fri, 19 Apr 2002 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSDSSAe>; Fri, 19 Apr 2002 14:00:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17656 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S312558AbSDSSAe>; Fri, 19 Apr 2002 14:00:34 -0400
Date: Fri, 19 Apr 2002 14:00:31 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: SSE related security hole
Message-ID: <20020419140031.A25519@redhat.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020418183639.20946.qmail@science.horizon.com.suse.lists.linux.kernel> <a9ncgs$2s2$1@cesium.transmeta.com.suse.lists.linux.kernel> <p73662naili.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 04:06:17PM +0200, Andi Kleen wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> > 
> > Perhaps the right thing to do is to have a description in data of the
> > desired initialization state and just F[NX]RSTOR it?
> 
> Sounds like the cleanest solution. The state could be saved at CPU bootup
> with just MXCSR initialized.
> 
> I'll implement that for x86-64.

Ummm...last I knew, fxrstor is *expensive*.  The fninit/xor regs setup is 
likely *very* much faster.  Someone should check this before we sacrifice 
100 cycles needlessly or something.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
