Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267970AbUHEVGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267970AbUHEVGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUHEVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:04:58 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:23710 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267973AbUHEVDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:03:10 -0400
Subject: Re: [PATCH] cleanup ACPI numa warnings
From: Dave Hansen <haveblue@us.ibm.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091738798.22406.9.camel@tdi>
References: <1091738798.22406.9.camel@tdi>
Content-Type: text/plain
Message-Id: <1091739702.31490.245.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 14:01:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 13:46, Alex Williamson wrote:
> +#ifdef ACPI_DEBUG_OUTPUT
> +#define acpi_print_srat_processor_affinity(header) { \
> +	struct acpi_table_processor_affinity *p = \
> +	                      (struct acpi_table_processor_affinity*) header; \
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Processor (id[0x%02x] " \
> +	                 "eid[0x%02x]) in proximity domain %d %s\n", \
> +	                 p->apic_id, p->lsapic_eid, p->proximity_domain, \
> +	                 p->flags.enabled?"enabled":"disabled")); }
> +
> +#define acpi_print_srat_memory_affinity(header) { \
> +	struct acpi_table_memory_affinity *p = \
> +	                         (struct acpi_table_memory_affinity*) header; \
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Memory (0x%08x%08x length " \
> +	                 "0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",\
> +	                 p->base_addr_hi, p->base_addr_lo, p->length_hi, \
> +	                 p->length_lo, p->memory_type, p->proximity_domain, \
> +	                 p->flags.enabled ? "enabled" : "disabled", \
> +	                 p->flags.hot_pluggable ? " hot-pluggable" : "")); }

Is there a reason that this can't be a normal function instead of a
9-line #define?

-- Dave

