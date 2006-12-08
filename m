Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759383AbWLHDAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759383AbWLHDAe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 22:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759495AbWLHDAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 22:00:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:46511 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759383AbWLHDAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 22:00:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hVPo+8oXUMVufyfSycYy3gpMwmLaenV61pUDwD1AjRmuABEO2zLYpAzw8zk/kWvn88/zQxtETedoLEmU4E9p1WoFdrW2xMP8vSlBQ38F7N7ai2JC85ArGO3EfzhwQlmKli/NPzau1b6IrUrAd/8jb1GJXDAIXnaWfg3+Y2LK0CQ=
Message-ID: <6dc076840612071900r657e78dag1377312d86042c67@mail.gmail.com>
Date: Fri, 8 Dec 2006 12:00:31 +0900
From: "Takashi Iwai" <takashi.iwai@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [git patch] improve INTx toggle for PCI MSI
Cc: "Jeff Garzik" <jeff@garzik.org>, "Takashi Iwai" <tiwai@suse.de>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, barkalow@iabervon.org
In-Reply-To: <Pine.LNX.4.64.0612071504570.3615@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061207225812.GA13917@havoc.gtf.org>
	 <Pine.LNX.4.64.0612071504570.3615@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/12/8, Linus Torvalds <torvalds@osdl.org>:
>
>
> On Thu, 7 Dec 2006, Jeff Garzik wrote:
> >
> > "it boots" on ICH7 at least.
>
> Ok. Pulled, pushed out.
>
> There was some noise saying that this may actually fix the problems with
> the NVidia "Intel HDA" sound situation? Can people who saw that issue try
> it out whether this just makes MSI works for them?
>
> Takashi added to the To: field, because he hopefully remembers and has a
> clue about the proper identities in question.. Iirc, you needed to have
> not only a NVidia chipset, but also have the legacy interrupt shared with
> some other device to see the problem.

Well, I'm on vacation now, so cannot answer much, too :)

IIRC, the problem was with HD-audio and network devices on Nvidia.
The explicit call of pci_intx() (currently implemented in hd-audio
driver locally) helped avoiding the orphan irq problem, but doesn't
fix the MSI problem itself.  (Some might have been fixed indeed,
but I don't have reports in hands.)


Takashi
