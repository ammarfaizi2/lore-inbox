Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUGLGbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUGLGbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 02:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUGLGb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 02:31:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:50343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266743AbUGLGbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 02:31:16 -0400
Date: Sun, 11 Jul 2004 23:30:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Eger <eger@havoc.gtf.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radeonfb: cleanup and little fixes
Message-Id: <20040711233002.1ec2100f.akpm@osdl.org>
In-Reply-To: <20040712062236.GA17610@havoc.gtf.org>
References: <20040712062236.GA17610@havoc.gtf.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Eger <eger@havoc.gtf.org> wrote:
>
> Dear Andrew, Please apply.
> 

Sure..

>  	if (rinfo->mon1_EDID)
>  	    kfree(rinfo->mon1_EDID);
>  	if (rinfo->mon2_EDID)
>  	    kfree(rinfo->mon2_EDID);

kfree(NULL) is legal, and this is a slow-path.  Those tests can be taken
out next time, unless such a thing offends you.
