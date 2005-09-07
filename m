Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVIGLqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVIGLqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVIGLqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:46:23 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:12040 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932121AbVIGLqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:46:22 -0400
Date: Wed, 7 Sep 2005 07:40:43 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: nazim khan <naz_taurus@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: How to find out kernel stack over flow?
Message-ID: <20050907114043.GB13878@hmsreliant.homelinux.net>
References: <20050907072824.98733.qmail@web52604.mail.yahoo.com> <431EA245.2040703@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431EA245.2040703@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 10:18:13AM +0200, Michal Schmidt wrote:
> nazim khan wrote:
> >I suspect that one of my module that I am inserting in
> >the kernel may be causing the stack overflow which is
> >leading to kernel crash (may because it is corrupting
> >some one lese memory).
> >
> >How can I find this out?
> 
> You could enable CONFIG_DEBUG_STACKOVERFLOW.
> If you showed us your module's source code, someone might see the bug.
> 
> Michal
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Additionally, if you have netconsole/netdump set up, you can examine the
resultant core file with the crash utility to find telltale signs of an
overflow.  Nominally a stack overflow results in the corruption of data at the
end of a neighboring task_struct.

Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
