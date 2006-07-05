Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWGEUSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWGEUSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWGEUSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:18:53 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:37001 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S965019AbWGEUSx
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 5 Jul 2006 16:18:53 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17580.7568.53140.84574@gargle.gargle.HOWL>
Date: Thu, 6 Jul 2006 00:14:08 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06CFA4@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06CFA4@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > I have added proposed by Nikita lines
 > 		if (pdflush_operation(background_writeout, 0))
 >                 writeback_inodes(&wbc);
 > and tested it with iozone. The throughput is 50-53 MB/sec. It is less
 > than 74-105 MB/sec results sent earlier.

If this change has any effect at all, then maximal number of pdflush
threads has been started. But there is only one device, so what are
these threads doing?

 > 
 > Leonid

Nikita.
