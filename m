Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVDFE3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVDFE3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 00:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVDFE3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 00:29:00 -0400
Received: from orb.pobox.com ([207.8.226.5]:55200 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262099AbVDFE26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 00:28:58 -0400
Date: Tue, 5 Apr 2005 23:28:50 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Re: [RFC 5/6]clean cpu state after hotremove CPU
Message-ID: <20050406042850.GE3611@otto>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com> <20050404052844.GB3611@otto> <1112593338.4194.362.camel@sli10-desk.sh.intel.com> <20050404153345.GC3611@otto> <1112666106.17861.62.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112666106.17861.62.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 09:55:06AM +0800, Li Shaohua wrote:

> On Mon, 2005-04-04 at 23:33, Nathan Lynch wrote:
> > No.  It should make zero difference to the scheduler whether the "play
> > dead" cpu hotplug or "physical" hotplug is being used.  
> Keeping some fields like 'cpu_load' are meanless for a hotadded CPU to
> me. Just ignore them?

Reinitializing such things during the CPU_UP_PREPARE case in
migration_call should be sufficient, if it's not done already.


Nathan
