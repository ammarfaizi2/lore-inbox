Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272287AbRIRPoN>; Tue, 18 Sep 2001 11:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272280AbRIRPn4>; Tue, 18 Sep 2001 11:43:56 -0400
Received: from ns.suse.de ([213.95.15.193]:52744 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272270AbRIRPms>;
	Tue, 18 Sep 2001 11:42:48 -0400
Date: Tue, 18 Sep 2001 17:43:12 +0200
From: Hubert Mantel <mantel@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010918174312.H6102@suse.de>
In-Reply-To: <20010917151957.A26615@codepoet.org> <9o5pfu$f03$1@ns1.clouddancer.com> <20010917223203.DACE3783EE@mail.clouddancer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010917223203.DACE3783EE@mail.clouddancer.com>; from klink@clouddancer.com on Mon, Sep 17, 2001 at 03:32:03PM -0700
Organization: SuSE Labs, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.4.9-4GB
X-GPG-Key: 1024D/B0DFF780
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, Colonel wrote:

> >$ cat /proc/partitions

[...]

> Works fine here:

[...]

> SCSI subsystem driver Revision: 1.00
> sym53c8xx: at PCI bus 0, device 9, function 0
> sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
> sym53c8xx: 53c875 detected with Symbios NVRAM
> sym53c8xx: at PCI bus 0, device 9, function 1
> 
> 
> Perhaps it is a driver effect?

You only have one single SCSI adapter?

I tried several things so far, and it seems you need the following to 
trigger the problem: You need at least two SCSI adapters that require 
different drivers (so two AHA2940s are not sufficient) and the drivers 
need to be loaded as modules.
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v
