Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269078AbUIXTjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269078AbUIXTjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269072AbUIXTjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:39:49 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:48824 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S269045AbUIXTjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:39:45 -0400
Date: Fri, 24 Sep 2004 12:39:42 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: David Wysochanski <davidw@netapp.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: reiserfs and SCSI oops seen in 2.6.9-rc2 with local SCSI disk IO
Message-ID: <20040924193942.GA17460@ip68-4-98-123.oc.oc.cox.net>
References: <4154372C.7070506@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154372C.7070506@netapp.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 11:03:08AM -0400, David Wysochanski wrote:
> I can reproduce this pretty easily with local disk.
[snip]

Make absolutely very very sure that you are *NOT* using SELinux --
reiserfs and SELinux do NOT get along right now (this is a known
problem). If you try to use the two together, you'll almost certainly
get freezes and oopses.

If you're seeing this type of problem even without SELinux, that's
interesting...

-Barry K. Nathan <barryn@pobox.com>

