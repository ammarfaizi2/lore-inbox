Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWEZJCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWEZJCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWEZJCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:02:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:15904 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751328AbWEZJCT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:02:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OE0vReAjDPYz5tKqA4iAlDE3EdgVDheqXNTXH7sa2s4PrJ9oramlNicCX+PFB7quOD1OrQQ1w5BIRlCbWCt/VcpTzl6Lyy34Q4KNujZJ9jEyWzV/fwQZXWQNY/fnh5orZ1QS6XRY5FAq8i66f0AztjjOf2nwOdhqNuNCimmagQ8=
Message-ID: <aec7e5c30605260202m531b0f01pfd244932d9fc99a9@mail.gmail.com>
Date: Fri, 26 May 2006 18:02:19 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Gerd Hoffmann" <kraxel@suse.de>
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4476B0F6.2000708@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044247.14219.13579.sendpatchset@cherry.local>
	 <m1slmystqa.fsf@ebiederm.dsl.xmission.com>
	 <1148545616.5793.180.camel@localhost> <4476B0F6.2000708@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Gerd Hoffmann <kraxel@suse.de> wrote:
> > 1a. The C-code in xen_machine_kexec() performs a hypercall.
> >
> > 1b. The hypervisor jumps to the assembly code.
> > After prepare we've created a NX-safe mapping for the control page. We
> > jump to that NX-safe address to transfer control to the assembly code.
>
> This is about kexec'ing the physical machine, not the virtual machine,
> right?

Correct, kexec:ing from dom0.

/ magnus
