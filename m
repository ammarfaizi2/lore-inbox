Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbUDQPpv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 11:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264001AbUDQPpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 11:45:51 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:6604 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S263991AbUDQPpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 11:45:44 -0400
Date: Sat, 17 Apr 2004 17:45:40 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: "Moore, Eric Dean" <Emoore@lsil.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: LSI Logic FC HBA / mptscsih hang
Message-ID: <20040417154540.GA23053@ii.uib.no>
Mail-Followup-To: "Moore, Eric Dean" <Emoore@lsil.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E570442C23E@exa-atlanta.se.lsil.com> <20040414211645.GA21837@ii.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414211645.GA21837@ii.uib.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 11:16:45PM +0200, Jan-Frode Myklebust wrote:
> On Wed, Apr 14, 2004 at 05:01:14PM -0400, Moore, Eric Dean wrote:
> > I can send you update 2.05.16 mpt driver RPM's for redhat 
> > in seperate email. Let me know if you can accept 
> > 17MB zip file.  

I saw the same problem with this 2.05.16 mpt driver. Now I also tried
upgrading to both the kernel-smp-2.6.5-1.326.i686.rpm from
http://people.redhat.com/arjanv/, and plain 2.6.6-rc1 kernel, and
these are also hanging with the same error:

Fusion MPT base driver 3.01.03
Copyright (c) 1999-2004 LSI Logic Corporation
PCI: Enabling device 0000:01:06.0 (0000 -> 0003)
mptbase: Initiating ioc0 bringup
ioc0: FC919X: Capabilities={Initiator,Target,LAN}
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
Fusion MPT SCSI Host driver 3.01.03
scsi1 : ioc0: LSIFC919X, FwRev=01000000h, Ports=1, MaxQ=1023, IRQ=11
mptscsih: ioc0: >> Attempting task abort! (sc=f7cccb00)
mptscsih: ioc0: >> Attempting target reset! (sc=f7cccb00)
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptscsih: ioc0: >> Attempting bus reset! (sc=f7cccb00)

btw: I also seem unable to send BREAK-t (or other magic sysrq
commands) via the serial console after this hang.. Maybe sysrq hasn't
been enabled that early in the boot, or the kernel is hanging too
hard..? 


   -jf
