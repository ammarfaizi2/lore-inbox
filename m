Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbTEMFP1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTEMFP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:15:27 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:7685 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262871AbTEMFPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:15:25 -0400
Date: Tue, 13 May 2003 06:27:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hch@infradead.org,
       greg@kroah.com, linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030513062748.A2677@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	greg@kroah.com, linux-security-module@wirex.com
References: <20030512200309.C20068@figure1.int.wirex.com> <20030512201518.X19432@figure1.int.wirex.com> <20030513050336.GA10596@Wotan.suse.de> <20030512222000.A21486@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512222000.A21486@figure1.int.wirex.com>; from chris@wirex.com on Mon, May 12, 2003 at 10:20:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:20:00PM -0700, Chris Wright wrote:
> This is too late.  Those are just for order in do_initcalls() which is
> well after some kernel threads have been created and filesystems have been
> mounted, etc.  This patch allows statically linked modules to catch
> the creation of such kernel objects and give them all consistent labels.

Patch looks fine to me.  Could you please make the initcalls mandatory for security
modules and remove the module exports for the regioster functions so peop can't
do the crappy check for each module whether it's already initialized stuff the early selinux
for LSM versions did?
