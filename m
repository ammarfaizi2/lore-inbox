Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWEMXJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWEMXJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWEMXJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:09:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:17874 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964788AbWEMXJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:09:45 -0400
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No DPMS for Console on x86_64
References: <20060513180158.GB2795@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 14 May 2006 01:09:41 +0200
In-Reply-To: <20060513180158.GB2795@localhost.localdomain>
Message-ID: <p73y7x55xoq.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer <thomasz@hostmaster.org> writes:
> 
> I wonder how difficult it would be, to port APM to the x86_64

Modern systems generally don't have working APM anymore.
There are replacement ACPI video options, but they seem to 
be rarely implemented because the system vendors assume the
video driver will do the job.

Also even if they had it wouldn't be implemented in the 64bit
kernel.

> architecture or to provide DPMS support in the FBDev drivers.

There is some code from PPC for that, but it is generally very 
PPC specific. Backlight control also varies a lot so it would
likely need tweaks for most laptops.

Or just run a X server. It also doesn't get this right always, but
at least sometimes.

-Andi
