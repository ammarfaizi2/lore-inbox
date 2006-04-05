Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWDENgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWDENgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWDENgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:36:16 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:64227
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751138AbWDENgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:36:16 -0400
Message-ID: <4433C7CE.2090001@microgate.com>
Date: Wed, 05 Apr 2006 08:36:14 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ptmx fix duplicate idr_remove
References: <1144175731.3485.18.camel@amdx2.microgate.com> <20060405005733.29b6868f.akpm@osdl.org>
In-Reply-To: <20060405005733.29b6868f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Except for this, in release_dev():
> 
> 	/* check whether both sides are closing ... */
> 	if (!tty_closing || (o_tty && !o_tty_closing))
> 		return;
> 
> if that's taken, we won't have run idr_remove() at all?

ptmx_open creates the ptm/pts pair.

If ptmx_open fails, the conditions
for releasing the ptm (and associated pts)
have been met: no active references.

-- 
Paul Fulghum
Microgate Systems, Ltd.
