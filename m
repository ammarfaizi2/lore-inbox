Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVDERpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVDERpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVDERnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:43:42 -0400
Received: from one.firstfloor.org ([213.235.205.2]:49606 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261846AbVDERS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:18:59 -0400
To: Christopher Allen Wing <wingc@engin.umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
	<Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu>
From: Andi Kleen <ak@muc.de>
Date: Tue, 05 Apr 2005 19:18:56 +0200
In-Reply-To: <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> (Christopher
 Allen Wing's message of "Mon, 4 Apr 2005 10:53:39 -0400 (EDT)")
Message-ID: <m18y3x16rj.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Allen Wing <wingc@engin.umich.edu> writes:

> On Sun, 3 Apr 2005, Mikael Pettersson wrote:
>
>> Well, first step is to try w/o ACPI. ACPI is inherently fragile
>> and bugs there can easily explain your timer problems. Either
>> recompile with CONFIG_ACPI=n, or boot with "acpi=off pci=noacpi".
>
>
> When I boot without ACPI (I used 'acpi=off pci=noacpi') the system fails
> to come up all the way; it hangs after loading the SATA driver. (but
> before the SATA driver finishes probing the disks)
>
> I'm guessing that the interrupt from the SATA controller is not getting
> through? Anyway, I assumed that ACPI was basically required for x86_64
> systems to work, is this not really the case?

Alternatively you can try to boot with noapic. Does that help?

-Andi
