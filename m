Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWCWXhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWCWXhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWCWXhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:37:22 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10154 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932567AbWCWXhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:37:21 -0500
Date: Fri, 24 Mar 2006 08:38:00 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [PATCH: 000/002] Catch notification of memory add event of ACPI
 via container driver.
Message-Id: <20060324083800.d1bb156f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
References: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006 22:41:05 +0900
Yasunori Goto <y-goto@jp.fujitsu.com> wrote:

>These 2 patches are to catch notification of new node's hot-add event via ACPI.



One more thing, this patch works for the case that memory device "PNP0C80" appears
in container device"ACPI0004,PNP0A05,PNP0A06". In this case, ACPI's notify just comes
to container device (not to memory device in it). This patch is necessary to deal with it.

I heared  that some of firmwares (will?) use this kind of design, memory in a container,
even if it's not NUMA.

-- Kame.

