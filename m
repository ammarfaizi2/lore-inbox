Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbREPHRd>; Wed, 16 May 2001 03:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbREPHRY>; Wed, 16 May 2001 03:17:24 -0400
Received: from gate.in-addr.de ([212.8.193.158]:6669 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S261805AbREPHRG>;
	Wed, 16 May 2001 03:17:06 -0400
Date: Wed, 16 May 2001 09:17:03 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Biardzki <cbi@cebis.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Storage - redundant path failover / failback - quo vadis linux?
Message-ID: <20010516091703.F573@marowsky-bree.de>
In-Reply-To: <Pine.LNX.4.21.0105160815100.10476-100000@ameise.opto.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <Pine.LNX.4.21.0105160815100.10476-100000@ameise.opto.de>; from "Christoph Biardzki" on 2001-05-16T08:34:00
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-05-16T08:34:00,
   Christoph Biardzki <cbi@cebis.net> said:

> I was investigating redundant path failover with FibreChannel disk devices
> during the last weeks. The idea is to use a second, redundant path to a
> storage device when the first one fails. Ideally one could also implement
> load balancing with these paths.
> 
> The problem is really important when using linux for mission-critical
> applications which require large amounts of external storage.

Yes.

Device handling under Linux in the face of HA generally faces some annoying
issues - the one you mention is actually the least of it ;-)

Error handling and reporting is the most annoying one to me - no good way to
find out whether a device has had an error. And even if the kernel logs a read
error on device sda1 - great, what LVM volumes are affected?

But on to your question... ;-)

> - The "T3"-Patch for 2.2-Kernels which patches the sd-Driver und the
> Qlogic-FC-HBA-Driver. When you pull an FC-Cable on a host equiped with two
> HBAs the failover is almost immediate and an automatic failback (after
> "repairing") is possible

I actually like this one best, if it was forward ported to 2.4.

> The low-level-approach of the "T3"-patch requires changes to the
> scsi-drivers and the hardware-drivers but provides optimal communication
> between the driver and the hardware

The changes required for the hardware drivers are rather minimal.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

