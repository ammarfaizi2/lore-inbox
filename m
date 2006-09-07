Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWIGESx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWIGESx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 00:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWIGESw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 00:18:52 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:58757 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964883AbWIGESw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 00:18:52 -0400
Message-ID: <44FF9DA8.10007@garzik.org>
Date: Thu, 07 Sep 2006 00:18:48 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tigran Aivazian <tigran@veritas.com>
Subject: Re: [PATCH] x86 microcode: don't check the size
References: <1157597227.2782.55.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1157597227.2782.55.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:
> IA32 manual says if micorcode update's size is 0, then the size is
> default size (2048 bytes). But this doesn't suggest all microcode
> update's size should be above 2048 bytes to me. We actually had a
> microcode update whose size is 1024 bytes. The patch just removed the
> check.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Why not explicitly check for zero, rather than removing the questionable 
less-than test?  The default size logic hasn't disappeared...

	Jeff



