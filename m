Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUDMSu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 14:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUDMSu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 14:50:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:59544 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263686AbUDMSu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 14:50:56 -0400
Date: Tue, 13 Apr 2004 11:50:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.5-mm4] sys_access race fix
Message-ID: <20040413115052.O22989@build.pdx.osdl.net>
References: <1081881778.5585.16.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1081881778.5585.16.camel@bluerhyme.real3>; from Fabian.Frederick@skynet.be on Tue, Apr 13, 2004 at 08:43:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabian Frederick (Fabian.Frederick@skynet.be) wrote:
> Andrew,
> 
> 	I'm trying to remove the race in sys_access code.
> AFAICS, fsuid is checked in "permission" level so I pushed real fsuid
> capture forward.At that state, I can task_lock (which was impossible
> before user_walk).Could you tell me if I can improve this one ?

This changes the semantics of the directory checks implicit
during the pathname resolution.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
