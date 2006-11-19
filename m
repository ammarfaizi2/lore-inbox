Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933276AbWKSUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933276AbWKSUwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933278AbWKSUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:52:44 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:1221 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S933276AbWKSUwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:52:43 -0500
Date: Sun, 19 Nov 2006 20:52:38 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andi Kleen <ak@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org
Subject: Re: reiserfs NET=n build error
Message-ID: <20061119205238.GD3078@ftp.linux.org.uk>
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com> <200611190650.49282.ak@suse.de> <45608FC2.5040406@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45608FC2.5040406@suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 12:09:22PM -0500, Jeff Mahoney wrote:
> > I would copy a relatively simple C implementation, like arch/h8300/lib/checksum.c
> 
> As long as the h8300 version has the same output as the x86 version.

As the matter of fact, h8300 version is severely broken and no, it
definitely does *not* give the same values.  Not even guaranteed
to be the same mod 0xffff is some cases, which is very much not
OK for networking uses.
