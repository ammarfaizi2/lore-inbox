Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272158AbRIRPkd>; Tue, 18 Sep 2001 11:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272264AbRIRPkQ>; Tue, 18 Sep 2001 11:40:16 -0400
Received: from ns.suse.de ([213.95.15.193]:25352 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272137AbRIRPjd>;
	Tue, 18 Sep 2001 11:39:33 -0400
Date: Tue, 18 Sep 2001 17:39:47 +0200
From: Hubert Mantel <mantel@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Erik Andersen <andersen@codepoet.org>, Colonel <klink@clouddancer.com>
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010918173947.F6102@suse.de>
In-Reply-To: <20010917151957.A26615@codepoet.org> <9o5pfu$f03$1@ns1.clouddancer.com> <20010917223203.DACE3783EE@mail.clouddancer.com> <20010917164824.A27116@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010917164824.A27116@codepoet.org>; from andersen@codepoet.org on Mon, Sep 17, 2001 at 04:48:24PM -0600
Organization: SuSE Labs, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.4.9-4GB
X-GPG-Key: 1024D/B0DFF780
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, Erik Andersen wrote:

> On Mon Sep 17, 2001 at 03:32:03PM -0700, Colonel wrote:
> > 
> > Works fine here:
> 
> But none of your devices have 2048 byte physical sectors, 
> which is the case with my MO drives, and that appears to 
> be the root of the problem,

No, the problem only seems to exist when the low level SCSI drivers are 
being used as modules, not linked into the kernel.

Just tried it with 2.4.10-pre10: sym53c8xx and aic7xxx loaded as module
==> "cat /proc/partitions" gives infinite output (and my /dev/hda does
not show up at all). Both drivers compiled into the kernel ==> everything 
is fine; even my /dev/hda shows up.

>  -Erik
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v
