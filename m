Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbUKDUf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbUKDUf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbUKDUfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:35:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:20451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262410AbUKDU1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:27:43 -0500
Date: Thu, 4 Nov 2004 12:27:38 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: do_execve calls destroy_context when init_new_context has failed
Message-ID: <20041104122738.I14339@build.pdx.osdl.net>
References: <20041104074411.GA30985@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041104074411.GA30985@localhost>; from frumplestillskins@yahoo.co.uk on Thu, Nov 04, 2004 at 02:44:11AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Meybohm (frumplestillskins@yahoo.co.uk) wrote:
> Who's right here?  fork or exec?

I think both are right.  The difference is on execve the mm is completely
fresh (specifically it's zeroed out, including the context).  On fork
it's manually copied from the parent, so destroying it could actually
destory some parent context.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
