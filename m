Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTAUKg5>; Tue, 21 Jan 2003 05:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTAUKg5>; Tue, 21 Jan 2003 05:36:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26892 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263991AbTAUKg5>; Tue, 21 Jan 2003 05:36:57 -0500
Date: Tue, 21 Jan 2003 11:46:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Ask devices to powerdown before S3 sleep
Message-ID: <20030121104601.GB24349@atrey.karlin.mff.cuni.cz>
References: <20030119214642.GA27885@elf.ucw.cz> <Pine.LNX.4.44.0301210241290.2653-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301210241290.2653-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > SUSPEND_RESUME phase is needed for turning off IO-APIC. [I believe
> > SUSPEND_DISABLE should be so simple that errors just should not be
> > there, and besides we would not know how to safely enable devices from
> > such weird state, anyway]. Please apply,
> 
> panic() is a bit on the extreme side no? I know diddly about ACPI and 
> the current code, but can't you check for _PS3 methods or _S3D mappings 
> for your devices before hand to be certain that the system can even go 
> down to S3 somewhat reliably?

At this point, you already DISABLED half of devices, and you don't
even know *which* ones. You can't just send them ENABLE and hope it
works.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
