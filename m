Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVLGWeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVLGWeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbVLGWeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:34:19 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26761 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751802AbVLGWeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:34:18 -0500
Subject: Re: [ckrm-tech] [RFC][Patch 3/5] Per-task delay accounting: Sync
	block I/O delays
From: Dave Hansen <haveblue@us.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>,
       Suparna Bhattacharya <bsuparna@in.ibm.com>
In-Reply-To: <439760CE.7050401@watson.ibm.com>
References: <43975D45.3080801@watson.ibm.com>
	 <439760CE.7050401@watson.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 14:33:55 -0800
Message-Id: <1133994835.30387.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 22:23 +0000, Shailabh Nagar wrote:
> 
> +       if (-EIOCBQUEUED == ret) {
> +               __attribute__((unused)) struct timespec start, end;
> +

Those "unused" things suck.  They're really ugly.

Doesn't making your delay functions into static inlines make the unused
warnings go away?

-- Dave

