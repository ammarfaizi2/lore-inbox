Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263189AbVFXHU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbVFXHU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbVFXHU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:20:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53148 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263189AbVFXHUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:20:51 -0400
Date: Fri, 24 Jun 2005 09:20:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [patch 02/38] CKRM e18: Processor Delay Accounting
Message-ID: <20050624072019.GA7191@elte.hu>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com> <20050623061754.354811000@w-gerrit.beaverton.ibm.com> <20050623091655.GA28722@elte.hu> <20050623093732.GA30848@elte.hu> <42BAF7AD.2050208@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BAF7AD.2050208@watson.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Shailabh Nagar <nagar@watson.ibm.com> wrote:

> Thanks. task_curr is what we needed. Would exporting task_curr be ok 
> or should we continue to wrap in a separate function ?

wrapping a non-exported function and then exporting it is not nice at 
all (it circumvents the non-exported status of that original function).  
But we can internal-export (EXPORT_GPL) task_curr() itself.

	Ingo
