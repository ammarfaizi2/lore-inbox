Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWFIRCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWFIRCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWFIRCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:02:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15546 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030233AbWFIRCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:02:38 -0400
Date: Fri, 9 Jun 2006 12:01:42 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Petr Baudis <pasky@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Let even non-dumpable tasks access /proc/self/fd
Message-ID: <20060609170142.GA23990@sergelap.austin.ibm.com>
References: <20060606233820.GL28014@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606233820.GL28014@pasky.or.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Baudis (pasky@suse.cz):
> This kernel patch fixes the problem by letting the process access its
> own /proc/self/fd - as far as I can see, this should be reasonably safe
> since for the process, this does not reveal "anything new". Feel free to
> comment on this.

Given that

	fd=open("/etc/shadow", "r");
	setuid(1000);
	read(fd, buf, 100);

is possible before this patch, I agree - nothing new is revealed with
this patch  :)

(I've been waiting to respond because it does make me nervous, but
it seems clear that is unwarranted)

thanks,
-serge
