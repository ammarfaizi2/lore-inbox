Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVKVANO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVKVANO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVKVANN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:13:13 -0500
Received: from fmr24.intel.com ([143.183.121.16]:27315 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S964783AbVKVANN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:13:13 -0500
Message-Id: <20051121233914.979360000@araj-sfield-2>
Date: Mon, 21 Nov 2005 15:39:14 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@muc.de, gregkh@suse.de, venkatesh.pallipadi@intel.com
Subject: [patch 0/2] Convert bigsmp to use flat physical mode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch converts bigsmp to use flat physical mode instead of logical 
cluster mode similar to what we use for x86_64. This helps with plugging some
race conditions with cpu hotplug (IPI-race) and other things. More details in 
the respective patches.

Andrew: Please consider for -mm for some exposure

The series has 2 patches.

- Change bigsmp to use flat physical mode instead of logical cluster
- If hotplug is enabled choose bigsmp mode by default.

Both the above are default behaviour for x86_64 builds.

I have tested on some dual core boxes, it will help more testing if people
who use bigsmp can give feedback would be great.

Cheers,
ashok

