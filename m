Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbUAKLuX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 06:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUAKLuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 06:50:23 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:46520 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265845AbUAKLuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 06:50:17 -0500
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       jbarnes@sgi.com, steiner@sgi.com
Subject: Re: [ACPI] RFC: ACPI table overflow handling
References: <16381.27904.580087.442358@gargle.gargle.HOWL>
	<200401080920.04906.bjorn.helgaas@hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 11 Jan 2004 06:49:46 -0500
In-Reply-To: <200401080920.04906.bjorn.helgaas@hp.com>
Message-ID: <yq0fzemiu1x.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bjorn" == Bjorn Helgaas <bjorn.helgaas@hp.com> writes:

Bjorn> On Thursday 08 January 2004 7:45 am, Jes Sorensen wrote:
>> I could just hack the NUMA srat_num_cpus handling code to have a
>> limit as IMHO it is a lot cleaner to improve the
>> acpi_table_parse_madt() API by adding a max_entries argument and
>> then have acpi_table_parse_madt spit out a warning if it found too
>> many entries.

Bjorn> I really like this idea.  I notice you didn't take the
Bjorn> opportunity to remove the ad hoc checking in ia64
Bjorn> acpi_parse_lsapic; probably that's the next step.  Also, did
Bjorn> you consider using max_entries==0 to signify "unlimited"?  Zero
Bjorn> seems like an otherwise useless value for max_entries and would
Bjorn> avoid having to choose an arbitrary limit.

Hi Bjorn,

Since it seems my efforts weren't for nothing then I'll take another
round on this one and clean it up further. Zero is such a pretty
number so I agree, lets make that be unlimited.

Cheers,
Jes
