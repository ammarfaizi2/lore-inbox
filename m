Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270017AbUJNJ63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270017AbUJNJ63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 05:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270019AbUJNJ63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 05:58:29 -0400
Received: from defender.easycracker.org ([217.160.180.132]:26317 "HELO
	s-und-t-linnich.de") by vger.kernel.org with SMTP id S270017AbUJNJ61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 05:58:27 -0400
Date: Thu, 14 Oct 2004 13:59:46 +0200
From: "mobil@wodkahexe.de" <mobil@wodkahexe.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
Message-Id: <20041014135946.1de129f0.mobil@wodkahexe.de>
In-Reply-To: <Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
	<Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 00:59:13 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> On Tue, 12 Oct 2004, mobil@wodkahexe.de wrote:
> 
> > after upgrading to 2.6.9-rc4 I'm getting the following message in
> > dmesg:
> > 
> > No local APIC present or hardware disabled
> > 
> > 2.6.9-rc3 and older kernels did not show this message. They showed:
> >  Local APIC disabled by BIOS -- reenabling.
> >  Found and enabled local APIC!
> 
>  As you've already been told, the local APIC is not being enabled by
> default anymore.  I think this change may be unfortunate for users, so
> I've proposed the change to be applied for systems using ACPI and then
> verbosely, so that the reason for the APIC being kept disabled is
> clear.  Unfortunately I have no system available for testing that uses
> ACPI, so I'm asking whether you could participate in testing of the
> following patch.  With the patch applied, you should either get a
> warning or the local APIC running (e.g. if you disable ACPI by
> specifying "noacpi").  Does the patch work for you?  For anyone else?
> 
>   Maciej
> 
> patch-2.6.9-rc4-lapic-5
>
> <snip patch>

Hi,

i tested your patch, but it did not apply correctly to a clean 2.6.9-rc4
tree for me. (patch -Np1 -i ../patch-2.6.9-rc4-lapic-5)

I applyed it manually, and when rebooting, i get the following:
 Local APIC won't be reenabled, ...
 You can...

When booting with 'pci=noacpi':
 Local APIC won't be reenabled, ...
 You can...

When booting with 'acpi=off':
 no output when running dmesg|grep -i apic
 
Regards, Sebastian
