Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWDKTTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWDKTTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWDKTTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:19:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751069AbWDKTTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:19:36 -0400
Date: Tue, 11 Apr 2006 11:18:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/7] tpm: reorganize sysfs files - Updated patch
Message-Id: <20060411111834.587e4461.akpm@osdl.org>
In-Reply-To: <1144765495.4917.25.camel@localhost.localdomain>
References: <1144679825.4917.10.camel@localhost.localdomain>
	<20060410144623.110895d0.akpm@osdl.org>
	<1144765495.4917.25.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall <kjhall@us.ibm.com> wrote:
>
> > Does that look OK?
> 
>  No this is not ok because in several of these cases the response to the
>  command is longer than tpm_cap thus the reason for the hardcoded size.

OK.

>  I can put in a max function though that compares the size of the
>  response and the tpm_cap.  The read functions will make sure the
>  response does not overflow the buffer should that length ever change in
>  the future.

Well, pretty much anything which will automatically increase the size of
that array in response to changing data structures would suit, thanks.

