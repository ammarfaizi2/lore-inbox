Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWCBAxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWCBAxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 19:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWCBAxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 19:53:54 -0500
Received: from ns1.suse.de ([195.135.220.2]:46480 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750799AbWCBAxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 19:53:53 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 01:55:46 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>
References: <20060301224647.GD1440@redhat.com> <20060301230317.GF1440@redhat.com>
In-Reply-To: <20060301230317.GF1440@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603020155.46534.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 00:03, Dave Jones wrote:
> On Wed, Mar 01, 2006 at 05:46:47PM -0500, Dave Jones wrote:
>  > This amused me.
>  >
>  > (17:43:34:davej@nemesis:~)$ ll /proc/acpi/processor/
>  > total 0
>  > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU1/
>  > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU2/
>  > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU3/
>  > (17:43:36:davej@nemesis:~)$
>
> Digging further. I notice more oddities (or maybe I've just
> misunderstood this -- corrections welcomed)

Probably related to Ashok's ACPI CPU hotplug patches.

What's the full bootup log?

> (17:59:02:davej@nemesis:~)$ cat
> /sys/devices/system/cpu/cpu0/topology/core_id 0
> (17:59:23:davej@nemesis:~)$ cat
> /sys/devices/system/cpu/cpu1/topology/core_id 0
>
> (17:59:38:davej@nemesis:~)$ cat
> /sys/devices/system/cpu/cpu0/topology/core_siblings
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
> (17:59:47:davej@nemesis:~)$ cat
> /sys/devices/system/cpu/cpu1/topology/core_siblings
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002
>
> Neither of these CPUs are HT / dual-core, so shouldn't these be the same ?

It looks like a standard dual socket machine. Each CPU is a sibling of its own
only.

-Andi
