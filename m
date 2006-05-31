Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWEaQXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWEaQXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWEaQXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:23:49 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:19898 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751669AbWEaQXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:23:49 -0400
Date: Wed, 31 May 2006 17:23:45 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Chad Reese <creese@caviumnetworks.com>
Subject: mem_map definition / declaration.
Message-ID: <20060531162345.GA19674@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm/memory defines mem_map and max_mapnr only if !CONFIG_NEED_MULTIPLE_NODES.
<linux/mm.h> declares mem_map[] if !CONFIG_DISCONTIGMEM.  Shouldn't
both depend on !CONFIG_FLATMEM?  As things are now mem_map may be
declared but not defined for a non-NUMA sparsemem system which may make
tracking a remaining mem_map reference in the code a little harder.

  Ralf
