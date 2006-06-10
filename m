Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbWFJShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbWFJShp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWFJSho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:37:44 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:27804 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030491AbWFJShn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:37:43 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 4/5] readahead: backoff on I/O error
Date: Sat, 10 Jun 2006 20:33:45 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Michael Tokarev <mjt@tls.msk.ru>, Jens Axboe <axboe@suse.de>
References: <20060609080801.741901069@localhost.localdomain> <349840680.03819@ustc.edu.cn>
In-Reply-To: <349840680.03819@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606102033.46844.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fengguang,

On Friday, 9. June 2006 10:08, Wu Fengguang wrote:
> Backoff readahead size exponentially on I/O error.
 
> With this patch, retries are expected to be reduced from, say, 256, to 5.
 
1. Would you mind to push this patch to -stable?

Reason: If killing a drive was hit in the field, this should be critical 
	enough.

2. Could you disable (at least optionally) read ahead complety 
  on the first IO error?

Reason: In a data recovery situation (hitting EIO quite often, 
	but not really sequentially) readahead is counter productive.
	E.g. trying to save an old CD with the cdparanoia software.


Regards

Ingo Oeser
