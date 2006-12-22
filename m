Return-Path: <linux-kernel-owner+w=401wt.eu-S1423128AbWLVOwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423128AbWLVOwi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423107AbWLVOwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:52:38 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:59210 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423021AbWLVOwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:52:37 -0500
X-Originating-Ip: 24.163.66.209
Date: Fri, 22 Dec 2006 09:43:31 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Rewrite unnecessary duplicated code to use
 FIELD_SIZEOF().
In-Reply-To: <20061222140550.GB26033@infradead.org>
Message-ID: <Pine.LNX.4.64.0612220942140.2047@localhost.localdomain>
References: <Pine.LNX.4.64.0612170738410.24046@localhost.localdomain>
 <20061220164651.4ee2e960.akpm@osdl.org> <20061222140550.GB26033@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-12.808, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006, Christoph Hellwig wrote:

> On Wed, Dec 20, 2006 at 04:46:51PM -0800, Andrew Morton wrote:
> > On Sun, 17 Dec 2006 07:43:39 -0500 (EST)
> > "Robert P. J. Day" <rpjday@mindspring.com> wrote:
> >
> > >   as with ARRAY_SIZE(), there are a number of places (mercifully, far
> > > fewer) that recode what could be done with the FIELD_SIZEOF() macro in
> > > kernel.h.
>
> Who introduced FIELD_SIZEOF?  The name is the wrong way around, it
> should either be SIZEOF_FIELD if you want the SIZEOF part of
> FIELD_SIZE if you want to follow the ARRAY_SIZE example/

that's the name as it *already* existed in kernel.h.  however, since
no one was actually using it yet, it's a piece of cake to give it a
better name.  either FIELD_SIZE or MEMBER_SIZE would work just fine.

rday
