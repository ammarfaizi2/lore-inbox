Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSJCPmH>; Thu, 3 Oct 2002 11:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSJCPmH>; Thu, 3 Oct 2002 11:42:07 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:55708 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261205AbSJCPmF>;
	Thu, 3 Oct 2002 11:42:05 -0400
Message-ID: <3D9C6537.2D52E074@us.ibm.com>
Date: Thu, 03 Oct 2002 10:41:43 -0500
From: Mike Tran <mhtran@us.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.40-evms i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Shawn <core@enodev.com>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
References: <02100216332002.18102@boiler> <20021003153256.B17513@infradead.org> <20021003100341.B32461@q.mn.rr.com> <20021003163117.A23642@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> On Thu, Oct 03, 2002 at 10:03:41AM -0500, Shawn wrote:
> > On 10/03, Christoph Hellwig said something like:
> > > On Wed, Oct 02, 2002 at 04:33:20PM -0500, Kevin Corry wrote:
> > > > EVMS provides a new, stand-alone subsystem to the kernel
> > >
> > > i.e. it duplictes existing block layer/volume managment functionality..
> >
> > Ok, LVM1 is non-existant if that's what you're referring to. Really,
> > this replaces LVM1, but your statement WRT md still has merit. As for
> > md duplication, it has been stated already that a preferred approach
> > might be to send only core functionality bits for now, leaving that
> > out till that question can be addressed.
>
> I speak of all drivers/md/* and fs/partitions/*.
>

I have sent Neil Brown an email asking for his thoughts on a possible code
merge.
Neil is on vacation until 10/7.

I would say that the EMVS MD code & original MD code are very similar.
The most significant difference is the MD array discovery and setup code.
EVMS MD does in-kernel discovery, whereas Linux MD has both in-kernel
discovery (via fs/partitions/check.c) and user space initiated discovery
(IOCTL).

Mike Tran


