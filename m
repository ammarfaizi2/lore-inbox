Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbULHPkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbULHPkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 10:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbULHPkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 10:40:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20651 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261231AbULHPkP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 10:40:15 -0500
Date: Wed, 8 Dec 2004 15:40:10 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20041208154010.GK10881@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E570230CA8C@exa-atlanta> <20041208140755.GA24779@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208140755.GA24779@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 08:07:55AM -0600, Matt Domsch wrote:
> > +} ld_device_address_t;
> 
> I would also suggest __attribute__((packed)) since you're sharing with
> userspace just to ensure you can never get it grown by the compiler
> (it shouldn't be, but just to be safe).

That's a bad idea, it forces the compiler to pessimise accesses to the
struct on most hardware.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
