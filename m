Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUBYM6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 07:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUBYM6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 07:58:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261309AbUBYM6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 07:58:16 -0500
Date: Wed, 25 Feb 2004 12:58:10 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-alpha1
Message-ID: <20040225125810.GT25779@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3E2@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3E2@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 07:34:01PM -0500, Mukker, Atul wrote:
> 6.	Single code to support *all* x86-32, IA64, and x86-64 platforms

No.  Megaraid is a PCI card.  Therefore this one codebase should support
*all* PCI-capable architectures, not just these three.  Nobody's requiring
that you test on all the weird and wonderful architectures out there, just
that you don't do things like

#if defined(__x86_64__) || defined(__ia64__)
#endif

when you really mean

#ifdef CONFIG_COMPAT
#endif

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
