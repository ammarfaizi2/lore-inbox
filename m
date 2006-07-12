Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWGLNQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWGLNQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWGLNQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:16:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14003 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750821AbWGLNQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:16:27 -0400
Subject: Re: [PATCH 4/5] PCI-Express AER implemetation: AER core and
	aerdriver
From: Arjan van de Ven <arjan@infradead.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1152691570.28493.250.camel@ymzhang-perf.sh.intel.com>
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com>
	 <1152688565.28493.218.camel@ymzhang-perf.sh.intel.com>
	 <1152688926.28493.223.camel@ymzhang-perf.sh.intel.com>
	 <1152689546.28493.232.camel@ymzhang-perf.sh.intel.com>
	 <1152691570.28493.250.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 15:16:24 +0200
Message-Id: <1152710184.3217.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + 
> +	struct semaphore rpc_sema;	/* 
> +					 * Semaphore access required to
> +					 * access, add, remove, or print AER
> +				 	 * aware devices in this RPC hierarchy
> +					 */


Hi, 

sorry to bug you again.. but is there a reason you're introducing a new
semaphore and not a mutex? From looking at the code it could/should be a
mutex...

Greetings,
   Arjan van de Ven

