Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSKVQvB>; Fri, 22 Nov 2002 11:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSKVQvA>; Fri, 22 Nov 2002 11:51:00 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:7944 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265002AbSKVQvA>; Fri, 22 Nov 2002 11:51:00 -0500
Date: Fri, 22 Nov 2002 16:57:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Sam Ravnborg <sam@ravnborg.org>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup
Message-ID: <20021122165756.A5626@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <mbligh@aracnet.com> <200211221640.gAMGetJ02979@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211221640.gAMGetJ02979@localhost.localdomain>; from James.Bottomley@HansenPartnership.com on Fri, Nov 22, 2002 at 10:40:55AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 10:40:55AM -0600, J.E.J. Bottomley wrote:
> > And every other header file is under the include path ... putting them
> > all mixed in with C files is just making a mess.
> 
> No, look at e.g. SCSI.  We have a scsi.h file in drivers/scsi which defines 
> subsystem specific things that we only use within SCSI.  We have 
> include/scsi/scsi.h which defines things other subsystems can use.

Which is pretty stupid, btw.  There are more than enough scsi HBA drivers
or emulation drivers outside drivers/scsi.  I have a longstanding plan
to rationalize the scsi headers (the current state is really really messy),
and that includes moving everything but the truly midlayer-specific parts
like non-exported function to headers in include/scsi/.

