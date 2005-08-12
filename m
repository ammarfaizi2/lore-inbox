Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVHLQhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVHLQhN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVHLQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:37:13 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:63461 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751022AbVHLQhM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:37:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SNjWdWX1SnkCcDaiJFWp3fvU7jtlHrrVOZw/waPCIE75nPYhayMr7RZKy1f4+eroC+jGjGziSnixdaKtNy3J6nLUd2nf13iIFy+Z4f8hKp6NqDXDc8spk6lR7662tWjUpSbEwwVQfUL14isSRCRgYCQZwTojmk4BuzZ9R/E8SNs=
Message-ID: <86802c44050812093774bf4816@mail.gmail.com>
Date: Fri, 12 Aug 2005 09:37:11 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: APIC version and 8-bit APIC IDs
Cc: Martin Wilck <martin.wilck@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050812145725.GD922@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel>
	 <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com>
	 <20050812133248.GN8974@wotan.suse.de>
	 <42FCA97E.5010907@fujitsu-siemens.com>
	 <42FCB86C.5040509@fujitsu-siemens.com>
	 <20050812145725.GD922@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So MPTABLE do not have problem with it, only acpi related...?

YH

On 8/12/05, Andi Kleen <ak@suse.de> wrote:
> On Fri, Aug 12, 2005 at 04:55:40PM +0200, Martin Wilck wrote:
> > I wrote:
> >
> > >>How so? The XAPIC version check should work there.
> > >
> > >ACPI: LAPIC (acpi_id[0x11] lapic_id[0x21] enabled)
> > >Processor #33 15:4 APIC version 16
> > >ACPI: LAPIC (acpi_id[0x12] lapic_id[0x26] enabled)
> > >Processor #38 15:4 APIC version 16
> >
> > Forget it. I have fallen prey to  this line:
> >
> >       processor.mpc_apicver = 0x10; /* TBD: lapic version */
> >
> > in arch/x86_64/kernel/mpparse.c.
> > I am used to get correct answers from Linux :-)
> 
> Heh. Should probably fix that. Can you file a bug with the ACPI
> people on http://bugzilla.kernel.org ? (or do a patch?)
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
