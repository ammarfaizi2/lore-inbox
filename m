Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269656AbUJABU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269656AbUJABU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 21:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269657AbUJABU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 21:20:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:59627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269656AbUJABU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 21:20:57 -0400
Date: Thu, 30 Sep 2004 18:20:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Jack O'Quin" <joq@io.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040930182053.B1973@build.pdx.osdl.net>
References: <1094967978.1306.401.camel@krustophenia.net> <20040920202349.GI4273@conscoop.ottawa.on.ca> <20040930211408.GE4273@conscoop.ottawa.on.ca> <1096581213.24868.19.camel@krustophenia.net> <87pt43clzh.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87pt43clzh.fsf@sulphur.joq.us>; from joq@io.com on Thu, Sep 30, 2004 at 07:37:06PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jack O'Quin (joq@io.com) wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > Another issue that was raised was that the mlock stuff is also
> > unnecessary, because rlimits can do this now.  Is this the case?
> 
> I don't know.  The idea was not explained in enough detail for me to
> understand if it would be simple enough to administer.  Where can I
> find out more?

This uses the basic rlimits infrastructure.  You can manage it manually
in a shell with ulimit -l, or you can use pam (pam_limits) to configure
per uid limits.  There's a pam doc that describes limits, and a manpage
for ulimit.  It's really easy to use, and should eliminate the need for
the mlock part of that module.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
