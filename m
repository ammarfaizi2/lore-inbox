Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755306AbWKMSNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbWKMSNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755307AbWKMSNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:13:37 -0500
Received: from mx1.suse.de ([195.135.220.2]:43693 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755306AbWKMSNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:13:37 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Date: Mon, 13 Nov 2006 19:13:31 +0100
User-Agent: KMail/1.9.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
References: <20061113162135.GA17429@in.ibm.com> <200611131822.44034.ak@suse.de> <20061113175947.GA13832@in.ibm.com>
In-Reply-To: <20061113175947.GA13832@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131913.32073.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This code (verify_cpu) is called while we are still in real mode. So it has
> to be present in low 1MB. Now in trampoline has been designed to switch to
> 64bit mode and then jump to the kernel hence kernel can be loaded anywhere
> even beyond (4G). So if we move this code into say arch/x86_64/kernel/head.S
> then we can't even call it.

I didn't mean to call it. Just #include it from a common file

-Andi
