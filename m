Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUENR6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUENR6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUENR6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:58:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:44997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbUENR6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:58:05 -0400
Date: Fri, 14 May 2004 10:58:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       chrisw@osdl.org, olaf+list.linux-kernel@olafdietsche.de,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] capabilites, take 2
Message-ID: <20040514105801.S21045@build.pdx.osdl.net>
References: <1084536213.951.615.camel@cube> <40A4DD7B.6070208@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40A4DD7B.6070208@myrealbox.com>; from luto@myrealbox.com on Fri, May 14, 2004 at 07:53:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> > This would be an excellent time to reconsider how capabilities
> > are assigned to bits. You're breaking things anyway; you might
> > as well do all the breaking at once. I want local-use bits so
> > that the print queue management access isn't by magic UID/GID.
> > We haven't escaped UID-as-priv if server apps and setuid apps
> > are still making UID-based access control decisions.
> 
> How many bits?  Or should it even be a bitmask?
> 
> I'm thinking either 64 or 128 for kernel-defined caps and either
> a seperate 128 bits or more or just a list for local-defined.

Starts to look like the list of LSM callbacks.  Making it bigger doesn't
help the simple issue, keep one lousy bit across execve().  All this
redesign seems wrong to do in 2.6.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
