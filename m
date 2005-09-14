Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbVINNP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVINNP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVINNP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:15:57 -0400
Received: from aun.it.uu.se ([130.238.12.36]:17289 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S965200AbVINNP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:15:57 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17192.8799.432221.729771@alkaid.it.uu.se>
Date: Wed, 14 Sep 2005 15:15:11 +0200
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc1: end_pfn undefined in amd64-agp.ko
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building amd64-agp as module in 2.6.14-rc1 for x86_64
results in an error about "end_pfn" being undefined.

Looks like someone did s/max_mapnr/end_pfn/ in x86_64's
page.h, but forgot to export end_pfn.

Should I stick the EXPORT_SYMBOL in mm/memory.c or
somewhere down in arch/x86_64/ ?

/Mikael
