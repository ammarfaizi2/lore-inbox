Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751951AbWCAXD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbWCAXD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWCAXD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:03:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10697 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751951AbWCAXD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:03:27 -0500
Date: Wed, 1 Mar 2006 18:03:17 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: ak@suse.de
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060301230317.GF1440@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	ak@suse.de
References: <20060301224647.GD1440@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301224647.GD1440@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 05:46:47PM -0500, Dave Jones wrote:
 > This amused me.
 > 
 > (17:43:34:davej@nemesis:~)$ ll /proc/acpi/processor/
 > total 0
 > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU1/
 > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU2/
 > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU3/
 > (17:43:36:davej@nemesis:~)$

Digging further. I notice more oddities (or maybe I've just
misunderstood this -- corrections welcomed)

(17:59:02:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu0/topology/core_id
0
(17:59:23:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu1/topology/core_id
0

(17:59:38:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu0/topology/core_siblings
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
(17:59:47:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu1/topology/core_siblings
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002

Neither of these CPUs are HT / dual-core, so shouldn't these be the same ?

(18:00:04:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu0/topology/thread_siblings
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
(18:00:09:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu1/topology/thread_siblings
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002

Ditto ?

		Dave

