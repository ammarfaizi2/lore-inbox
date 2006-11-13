Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932800AbWKMTWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbWKMTWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932818AbWKMTWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:22:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54971 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932812AbWKMTWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:22:52 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
References: <20061113162135.GA17429@in.ibm.com>
	<200611131822.44034.ak@suse.de> <20061113175947.GA13832@in.ibm.com>
	<200611131913.32073.ak@suse.de>
Date: Mon, 13 Nov 2006 12:21:05 -0700
In-Reply-To: <200611131913.32073.ak@suse.de> (Andi Kleen's message of "Mon, 13
	Nov 2006 19:13:31 +0100")
Message-ID: <m14pt3qhjy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> This code (verify_cpu) is called while we are still in real mode. So it has
>> to be present in low 1MB. Now in trampoline has been designed to switch to
>> 64bit mode and then jump to the kernel hence kernel can be loaded anywhere
>> even beyond (4G). So if we move this code into say arch/x86_64/kernel/head.S
>> then we can't even call it.
>
> I didn't mean to call it. Just #include it from a common file

I believe the duplication winds up happening in setup.S

Eric
