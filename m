Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWEIPL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWEIPL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWEIPL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:11:58 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:52960 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751400AbWEIPL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:11:57 -0400
In-Reply-To: <20060509093614.GB26953@infradead.org>
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
Sensitivity: 
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, suparna@in.ibm.com
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OFB21F3208.CA125B3A-ON41257169.005345DD-41257169.005375F5@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 9 May 2006 16:11:36 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 09/05/2006 16:12:49
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Christoph Hellwig <hch@infradead.org> wrote on 09/05/2006 10:36:14:

> On Tue, May 09, 2006 at 12:35:08PM +0530, Prasanna S Panchamukhi wrote:
> > This patch provides two interfaces to insert and remove
> > user space probes. Each probe is uniquely identified by
> > inode and offset within that executable/library file.
> > Insertion of a probe involves getting the code page for
> > a given offset, mapping it into the memory and then inserting
> > the breakpoint at the given offset. Also the probe is added
> > to the uprobe_table hash list. A uprobe_module data structure
> > is allocated for every probed application/library image on disk.
> > Removal of a probe involves getting the code page for a given
> > offset, mapping that page into the memory and then replacing
> > the breakpoint instruction with a the original opcode.
> > This patch also provides aggregate probe handler feature,
> > where user can define multiple handlers per probe.
>
> This introduces interfaces that aren't used anywhere in the following
> patches.  That is completely not acceptable.  Please provide a proper
> userspace interface to this functionality, e.g. something based on the
> RPN code from Richard's dprobes.
>

Christoph, what are you asking for here? Surely not the RPN interpreter. I
thought everyone agreed that that was massive bloatware and that a binary
interface viz kprobes was a much better implementation.

