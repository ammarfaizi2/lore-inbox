Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVIMW1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVIMW1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVIMW1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:27:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:49078 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932506AbVIMW1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:27:18 -0400
Date: Tue, 13 Sep 2005 15:25:19 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Message-ID: <20050913222519.GA1308@us.ibm.com>
References: <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com> <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com> <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com> <20050913203611.GH32395@parisc-linux.org> <43273E6C.9050807@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43273E6C.9050807@adaptec.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 05:02:36PM -0400, Luben Tuikov wrote:
> On 09/13/05 16:36, Matthew Wilcox wrote:
> > On Tue, Sep 13, 2005 at 04:23:42PM -0400, Luben Tuikov wrote:
> > 
> >>A SCSI LUN is not "u64 lun", it has never been and it will
> >>never be.
> >>
> >>A SCSI LUN is "u8 LUN[8]" -- it is this from the Application
> >>Layer down to the _transport layer_ (if you cared to look at
> >>_any_ LL transport).

Not all HBA drivers implement a mapping to a SCSI transport, we have
raid drivers and even an FC driver that has its own lun definition that
does not fit any SAM or SCSI spec.

I think the only HBA's today that can handle an 8 byte lun are lpfc and
iscsi (plus new SAS ones).

So, we can't have one "LUN" that fits all, and it makes no sense to call
it a LUN when it is really a wtf.

-- Patrick Mansfield
