Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbUAHQUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265481AbUAHQUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:20:21 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:27551 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S265389AbUAHQUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:20:16 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] RFC: ACPI table overflow handling
Date: Thu, 8 Jan 2004 09:20:04 -0700
User-Agent: KMail/1.5.4
Cc: acpi-devel@lists.sourceforge.net, jbarnes@sgi.com, steiner@sgi.com
References: <16381.27904.580087.442358@gargle.gargle.HOWL>
In-Reply-To: <16381.27904.580087.442358@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401080920.04906.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 January 2004 7:45 am, Jes Sorensen wrote:
> I could just hack the NUMA srat_num_cpus handling code to have a limit
> as IMHO it is a lot cleaner to improve the acpi_table_parse_madt() API
> by adding a max_entries argument and then have acpi_table_parse_madt
> spit out a warning if it found too many entries.

I really like this idea.  I notice you didn't take the opportunity to
remove the ad hoc checking in ia64 acpi_parse_lsapic; probably that's
the next step.  Also, did you consider using max_entries==0 to signify
"unlimited"?  Zero seems like an otherwise useless value for max_entries
and would avoid having to choose an arbitrary limit.

