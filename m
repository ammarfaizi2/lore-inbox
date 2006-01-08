Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752636AbWAHOi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbWAHOi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbWAHOi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:38:59 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:19652 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1752629AbWAHOi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:38:58 -0500
Message-ID: <43C12404.1010306@ens-lyon.org>
Date: Sun, 08 Jan 2006 09:39:00 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>	<43C0172E.7040607@ens-lyon.org>	<20060107145800.113d7de5.akpm@osdl.org>	<43C050FA.9040400@ens-lyon.org> <20060108042425.4d0b8a76.akpm@osdl.org>
In-Reply-To: <20060108042425.4d0b8a76.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Well whatever bug it is, it's in Linus's tree now.  Happens for me too.
>
>  
>
Happens for you in -git4 ? Does not here...

Brice



>I traced the failure down as far as acpi_processor_get_performance_info(),
>where it's failing here:
>
>	status = acpi_get_handle(pr->handle, "_PCT", &handle);
>	if (ACPI_FAILURE(status)) {
>		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>				  "ACPI-based processor performance control unavailable\n"));
>		return_VALUE(-ENODEV);
>	}
>
>
>  
>

