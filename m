Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWERPzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWERPzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWERPzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:55:33 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:39832
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751035AbWERPzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:55:32 -0400
Date: Thu, 18 May 2006 16:54:57 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, nickpiggin@yahoo.com.au,
       haveblue@us.ibm.com, bob.picco@hp.com, mingo@elte.hu, mbligh@mbligh.org,
       ak@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/2] Zone boundary alignment fixes, cleanups v2
Message-ID: <exportbomb.1147967697@pinky>
References: <20060511005952.3d23897c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20060511005952.3d23897c.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Lets try that again, here is the correct patch this time.]

[Sorry for the delay, we've been busy looking to see what is
responsible for the ia64 issues with architecture independant
zone sizing.]

Following this email are two cleanup patches for the
UNALIGNED_ZONE_BOUNDARIES support in -mm.

zone-init-check-and-report-unaligned-zone-boundaries-fix --
  we currently will pointlessly report zones as missaligned even
  though they are empty and will report the first zone which can
  never be missaligned assuming node_mem_map is aligned correctly.

zone-allow-unaligned-zone-boundaries-spelling-fix -- when the
  spelling errors in zone-allow-unaligned-zone-boundaries-spelling
  were fixed the configuration options were not updated.

Both of the above patches slot into the linux-2.6.17-rc4-mm1 patch
set next to their main patches.  Amazingly, they will also apply
on top of linux-2.6.17-rc4-mm1, I don't know what patch has been
taking but it rocks.

-apw
