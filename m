Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWC2W6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWC2W6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWC2W6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:58:10 -0500
Received: from ozlabs.org ([203.10.76.45]:56300 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751193AbWC2W6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:58:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17451.4345.531029.950930@cargo.ozlabs.ibm.com>
Date: Thu, 30 Mar 2006 09:58:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Move pSeries firmware feature setup into platforms/pseries
In-Reply-To: <20060329220701.GE452@redhat.com>
References: <200603230714.k2N7EmH1021685@hera.kernel.org>
	<20060329195212.GA19236@redhat.com>
	<17451.866.287446.68155@cargo.ozlabs.ibm.com>
	<20060329220701.GE452@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:

> See firmware_has_feature() in include/asm-powerpc/firmware.h

In my clone of Linus' linux-2.6 tree, it looks like this:

#define firmware_has_feature(feature)					\
	((FW_FEATURE_ALWAYS & (feature)) ||				\
		(FW_FEATURE_POSSIBLE & powerpc_firmware_features & (feature)))

Perhaps you need to do another pull?

Paul.
