Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264947AbTLMMDj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 07:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTLMMDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 07:03:39 -0500
Received: from holomorphy.com ([199.26.172.102]:48001 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264947AbTLMMDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 07:03:37 -0500
Date: Sat, 13 Dec 2003 04:03:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: neel vanan <neelvanan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: acpi related error.....
Message-ID: <20031213120334.GP8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	neel vanan <neelvanan@yahoo.com>, linux-kernel@vger.kernel.org
References: <20031206054720.GN8039@holomorphy.com> <20031213115733.79739.qmail@web9505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213115733.79739.qmail@web9505.mail.yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 03:57:33AM -0800, neel vanan wrote:
> Currently i am working on RedHat9.0 kernel 2.4.20-8, i
> am compiling kernel 2.6.0-test11 with NUMA and SMP
> enabled. I had selected summit though i am having
> non-summit box. When i am trying to make bzImage in
> the last i get this message:
> drivers/built-in.o(.init.text+0x30cf): In function
> `acpi_parse_slit':
> : undefined reference to `acpi_numa_slit_init'
> drivers/built-in.o(.init.text+0x30f0): In function
> `acpi_parse_processor_affinity':
> : undefined reference to
> `acpi_numa_processor_affinity_init'

You are likely enabling CONFIG_NUMA on a PC subarch or trying to build
CONFIG_X86_SUMMIT without CONFIG_ACPI; this is ridiculous as PC means
non-NUMA and Summit means ACPI. I'm not sure how you selected this
combination.

Best to turn off CONFIG_NUMA unless you have an x440, x445, or NUMA-Q.


-- wli
