Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUCCVij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUCCVij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:38:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:61326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261159AbUCCVih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:38:37 -0500
Date: Wed, 3 Mar 2004 13:38:35 -0800
From: Chris Wright <chrisw@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild will remove .c files
Message-ID: <20040303133835.H21045@build.pdx.osdl.net>
References: <20040303123406.G21045@build.pdx.osdl.net> <20040303210715.GA2229@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040303210715.GA2229@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Mar 03, 2004 at 10:07:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sam Ravnborg (sam@ravnborg.org) wrote:
> What happens here is that make resort to a chained rule to create the
> irlan.o file.
> The chain goes from SCCS/%.c -> %.c -> %.s -> %.o
> 
> The two files %.c and %.s is considered intermidiate files, and make
> guarantees that intermidiate files that did not exist when
> make was called, does not exists when make exists.
> This is reported by make with the "rm ..." line.

Ah, I was trying to find it in kbuild.

> First my make documentatin say the make would use "rm -f ...",not "rm".
> What make version do you use?

GNU Make 3.80

> Also I would expect to see irlan_client.s to be deleted also - did you miss that?
> It may show up a bit later.

No, it is not deleted.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
