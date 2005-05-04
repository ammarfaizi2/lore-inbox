Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVEDTGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVEDTGB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVEDTGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:06:01 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:38536 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261379AbVEDTFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:05:54 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/1] Uml: kludgy compilation fixes for x86-64 subarch modules support [for -mm]
Date: Wed, 4 May 2005 21:01:30 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com,
       linux-kernel@vger.kernel.org, ak@suse.de
References: <20050501184515.F1AA48D835@zion> <20050502165103.6d76f394.akpm@osdl.org>
In-Reply-To: <20050502165103.6d76f394.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505042101.30458.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 May 2005 01:51, Andrew Morton wrote:
> blaisorblade@yahoo.it wrote:
> > These are some trivial fixes for the x86-64 subarch module support. The
> > only potential problem is that I have to modify
> > arch/x86_64/kernel/module.c, to avoid copying the whole of it.
> >
> > I can't use it verbatim because it depends on a special vmalloc-like area
> > for modules, which for now (maybe that's to fix, I guess not) UML/x86-64
> > has not. I went the easy way and reused the i386 vmalloc()-based
> > allocator.
>
> Why is this "for -mm" and not for -linus?
That's a report on the current "review/testing" status, in this case because I 
wanted an ACK from Andi Kleen. Which acked it for himself but warned about 
the possible breakage for other archs.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

