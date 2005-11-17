Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVKQSru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVKQSru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVKQSrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:47:49 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:24310 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932480AbVKQSrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:47:49 -0500
Date: Thu, 17 Nov 2005 10:47:45 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Subject: dma_is_consistent() is nonsensical...
Message-ID: <20051117184745.GA23776@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Working on adding support for cache-coherent operation to ARM and 
wondering exactly what this API is supposed to do. From the name it
is obviously supposed to tell the caller (only one in the kernel...
drivers/scsi/53c700.c) whether the provided dma_handle is cache-coherent
or not.  In the case of multiple DMA domains where certain devices
are on snooping interfaces and others are not we really want to know what
device the DMA address is on so can we add a struct device* ptr to this 
function? Or can we just kill it since nobody is actually using it? 
Calling dma_alloc_coherent should always return coherent/consistent 
(why the different naming conventions too?) so I don't really see a real 
use case. 

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

"To question your government is not unpatriotic - to not question your
 government is unpatriotic." -  Senator Chuck Hagel (R-NE) - Nov 15, 2005
