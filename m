Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWCXLnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWCXLnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWCXLnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:43:03 -0500
Received: from mail.suse.de ([195.135.220.2]:35746 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932555AbWCXLnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:43:01 -0500
From: Andi Kleen <ak@suse.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: 92c05fc1a32e5ccef5e0e8201f32dcdab041524c breaks x86_64 compile.
Date: Fri, 24 Mar 2006 12:36:20 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200603241529.28811.ncunningham@cyclades.com> <20060324121418.c4c03e1d.khali@linux-fr.org>
In-Reply-To: <20060324121418.c4c03e1d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200603241236.20990.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 12:14, Jean Delvare wrote:
> Hi Nigel, Andi, all,
> 
> > It looks to me like the above commit from Andi causes a compilation failure on 
> > x86_64, because it makes pci_mmcfg_init non static:
> > 
> > arch/x86_64/pci/mmconfig.c:152: error: conflicting types for ‘pci_mmcfg_init’
> > arch/i386/pci/pci.h:85: error: previous declaration of ‘pci_mmcfg_init’ was 
> > here
> > make[1]: *** [arch/x86_64/pci/mmconfig.o] Error 1
> > make: *** [arch/x86_64/pci] Error 2
> 
> I just hit the same compilation failure. Here's a fix which works for
> me.

This was my mistake. I fixed the problem in the wrong patch. And then
Greg submitted only the one patch. I think Andrew fixed it up by 
submitting the other (unrelated) patch which fixes this too.

Thanks.
-Andi

