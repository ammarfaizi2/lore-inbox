Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756311AbWKRNTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311AbWKRNTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756317AbWKRNTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:19:37 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:5254 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756311AbWKRNTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:19:36 -0500
Date: Sat, 18 Nov 2006 08:19:04 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: Re: [PATCH 2/20] x86_64: Assembly safe page.h and pgtable.h
Message-ID: <20061118131904.GC17248@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com> <20061117223721.GC15449@in.ibm.com> <200611180949.15243.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611180949.15243.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 09:49:14AM +0100, Andi Kleen wrote:
> On Friday 17 November 2006 23:37, Vivek Goyal wrote:
> >
> > This patch makes pgtable.h and page.h safe to include
> > in assembly files like head.S.  Allowing us to use
> > symbolic constants instead of hard coded numbers when
> > refering to the page tables.
> 
> I still think that macro is horrible ugly and the use of that
> macro should be minimized as suggested earlier.
> 
Hi Andi,

Personally I think maintenance is easier if we don't try to discriminate
between the constants which require that macro and which don't require.

But if you don't like it, then its ok, I will only apply it to places
where it is really required and breaks the things (like shift operations).

Will do that change in next posting.

Thanks
Vivek
