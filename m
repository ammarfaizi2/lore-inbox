Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291666AbSBAKNS>; Fri, 1 Feb 2002 05:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291665AbSBAKNI>; Fri, 1 Feb 2002 05:13:08 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:35263 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291666AbSBAKM5>; Fri, 1 Feb 2002 05:12:57 -0500
Date: Fri, 1 Feb 2002 05:12:51 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Joe Thornber <thornber@fib011235813.fsnet.co.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>, lvm-devel@sistina.com,
        Jim McDonald <Jim@mcdee.net>, Andreas Dilger <adilger@turbolabs.com>,
        linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020201051251.B10893@devserv.devel.redhat.com>
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com> <20020131125211.A8934@fib011235813.fsnet.co.uk> <20020201045518.A10893@devserv.devel.redhat.com> <20020131130913.A8997@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020131130913.A8997@fib011235813.fsnet.co.uk>; from thornber@fib011235813.fsnet.co.uk on Thu, Jan 31, 2002 at 01:09:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 01:09:13PM +0000, Joe Thornber wrote:
> 
> Now our hero decides to PV move PV2 to PV4:
> 
> 1. Suspend our LV (254:3), this starts queueing all io, and flushes
>    all pending io. 

But "flushes all pending io" is *far* from trivial. there's no current
kernel functionality for this, so you'll have to do "weird shit" that will
break easy and often.

Also "suspending" is rather dangerous because it can deadlock the machine
(think about the VM needing to write back dirty data on this LV in order to
 make memory available for your move)...

Greetings,
  Arjan van de Ven



