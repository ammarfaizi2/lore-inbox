Return-Path: <linux-kernel-owner+w=401wt.eu-S1751156AbWLLGS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWLLGS1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWLLGS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:18:27 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:39352 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751156AbWLLGS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:18:26 -0500
X-YMail-OSG: DSTgBA4VM1nBZ67CqJ_NfSR8j9UsEHRpdDKytRs0Jc.YnGc1RA6XTDIqWIWrHcSqKc5J6MdDBTX21ygObRKc.dYo6FFZrr5a_N3OLyOlKeMWR9kcqQlT46QvgfIac3n9FFvQBJU9b8W3jBs-
Date: Mon, 11 Dec 2006 22:18:23 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Karsten Weiss <K.Weiss@science-computing.de>, Andi Kleen <ak@suse.de>
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>
Subject: amd64 iommu causing corruption? (was Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!)
Message-ID: <20061212061823.GA303@tuatara.stupidest.org>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 10:24:02AM +0100, Karsten Weiss wrote:

> We could not reproduce the data corruption anymore if we boot the
> machines with the kernel parameter "iommu=soft" i.e. if we use
> software bounce buffering instead of the hw-iommu. (As mentioned
> before, booting with mem=2g works fine, too, because this disables
> the iommu altogether.)

I can confirm this also seems to be the case for me, I'm still doing
more testing to confirm this.  But it would seem:

nforce4, transfer of a large mount of data with 4GB+ of RAM I get some
corruption.  This is present on both the nv SATA and also Sil 3112
connected drives.

Using iommu=soft so far seems to be working without any corruption.



I still need to do more testing on other machines which have less
memory (so the IOMMU won't be in use there either) and see if there
are problems there.
