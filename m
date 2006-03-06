Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWCFLbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWCFLbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWCFLbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:31:11 -0500
Received: from canuck.infradead.org ([205.233.218.70]:49100 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750900AbWCFLbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:31:09 -0500
Subject: Re: PROBLEM:  rt_sigsuspend() does not return EINTR on 2.6.16-rc2+
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1141633685.7634.13.camel@localhost.localdomain>
References: <1141521960.7628.9.camel@localhost.localdomain>
	 <1141557862.3764.47.camel@pmac.infradead.org>
	 <1141633685.7634.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 11:31:05 +0000
Message-Id: <1141644665.4110.40.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 21:28 +1300, Matthew Grant wrote:
> OK, a major piece of software is broken for mounting removable media.
> A kernel upgrade from 2.6.15 SHOULDn't do that.  
> 
> Could you please tell me where go I go next?

Your approach seemed fine -- strace it, look for important differences.
You were quite right to pick up on the difference in sigsuspend()
behaviour, but in reality it's going to be a false positive, so you
should keep looking for other differences. 

And as Andrew says, give us enough information to reproduce for
ourselves -- and describe the real problem, because 'rt_sigsuspend()
does not return -EINTR' isn't it, although was a reasonable enough
assumption on your part.

-- 
dwmw2

