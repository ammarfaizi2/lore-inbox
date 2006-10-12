Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWJLHZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWJLHZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWJLHZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:25:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:482 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030500AbWJLHZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:25:26 -0400
Date: Thu, 12 Oct 2006 09:25:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-thinkpad@linux-thinkpad.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       acpi-devel@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [ltp] Re: X60s w/t kern 2.6.19-rc1-git: two BUG warnings
Message-ID: <20061012072501.GA4415@elf.ucw.cz>
References: <20061010062826.GC9895@gimli> <452BECAE.2070001@goop.org> <m17iz7oj3w.fsf@ebiederm.dsl.xmission.com> <20061011070650.GA7003@gimli> <20061012070132.GA27832@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012070132.GA27832@gimli>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The bug is from the attempt to allocate an already allocated irq.
> > > So it appears somehow in the save/restore mess the msi code
> > > thought the irq code was allocates but the irq code did not?
> > > 
> > 
> > this morning I tried and booted the machine with pci=nomsi
> > the BUG does not come up as expected but the symptom of loosing ACPI after
> > suspend/resume remains...
> > 
> I have to say sorry for insisting on the ACPI issue
> after digging a little deeper I found that it must come from somewhere in
> the ibm_acpi code and maybe even in a helper script. I still have to seek
> for that one and read the ibm_acpi patches and discussion that go on for
> over a week now in ltp...
> 
> maybe soneone can quickly tell me, what it is trying to point out with this
> messages from the suspend or resume code:
> 
> Calling INT 0x15 (F000:5E81)
>  EAX is 0x10005F00
> Calling INT 0x15 (F000:5E81)
>  EAX is 0x10005F40
> Calling INT 0x15 (F000:5E81)
>  EAX is 0x5F34
> Calling INT 0x15 (F000:5E81)
>  EAX is 0x5F35

That is vbetool code, IIRC. Ignore it.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
