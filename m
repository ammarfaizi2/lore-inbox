Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135699AbREBRtR>; Wed, 2 May 2001 13:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135696AbREBRtJ>; Wed, 2 May 2001 13:49:09 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:55125 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135685AbREBRtF>; Wed, 2 May 2001 13:49:05 -0400
Message-ID: <3AF048FA.1B5EA399@redhat.com>
Date: Wed, 02 May 2001 13:50:50 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Anderson <mike.anderson@us.ibm.com>
CC: Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <200105011445.KAA01117@localhost.localdomain><3AEEDFFC.409D8271@redhat.com> <15086.60620.745722.345084@gargle.gargle.HOWL> <3AF025AE.511064F3@redhat.com> <20010502102037.A19349@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Anderson wrote:
> 
> Doug,
> 
> A question on clarification.
> 
> Is the configuration you are testing have both FC adapters going to the same
> port of the storage device (mutli-path) or to different ports of the storage
> device (mulit-port)?
> 
> The reason I ask is that I thought if you are using SCSI-2 reserves that the
> reserve was on a per initiator basis. How does one know which path has the
> reserve?

Reservations are global in nature in that a reservation with a device will
block access to that device from all other initiators, including across
different ports on multiport devices (or else they are broken and need a
firmware update).

> On a side note. I thought the GFS project had up leveled there locking / fencing
> into a API called a locking harness to support different kinds of fencing
> methods. Any thoughts if this capability could be plugged into this service so
> that users could reduce recoding depending on which fencing support they
> selected.

I wouldn't know about that.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
