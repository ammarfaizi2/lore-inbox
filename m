Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137197AbREKSNq>; Fri, 11 May 2001 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137199AbREKSNh>; Fri, 11 May 2001 14:13:37 -0400
Received: from adsl-64-168-227-89.dsl.sntc01.pacbell.net ([64.168.227.89]:26122
	"EHLO brian-laptop.dyn.us.mvd") by vger.kernel.org with ESMTP
	id <S137196AbREKSNS>; Fri, 11 May 2001 14:13:18 -0400
Date: Fri, 11 May 2001 11:13:00 -0700
From: "Brian J. Murrell" <brian@mountainviewdata.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ip autoconfig with modules, kernel 2.4
Message-ID: <20010511111300.A27378@brian-laptop.us.mvd>
In-Reply-To: <20010510094953.C28095@brian-laptop.us.mvd> <20010510180039.D9771@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010510180039.D9771@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, May 10, 2001 at 06:00:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2001 at 06:00:39PM +0100, Russell King wrote:
> 
> Hmm, if you've got userspace up and running, and loaded kernel
> modules using insmod, then what's wrong about running a dhcp,
> bootp or rarp client from userspace?

In theory, and for just ip configuration, nothing.

I should have given more information though.  My goal is actually to
NFSRoot the machine being booted.  I could not determine a way to get
the "root path" attribute given by the dhcp/bootp server from
userspace back to the kernel so that it can
"change_root()/mount_root()" with it.  I seem to recall there was a
proc interface for doing this at one time (in the 2.2 kernel) but it
seemed to have went away.

> You can then drop the
> kernel space IP autoconfiguration code.

If there were a way to tell the kernel, from userspace, for
change_root()/mount_root() where the nfsroot path was, yes.  I have
been hunting through all of the (nfs) root mount code and I don't see
it.  It looks like it can be set either on the command line, or by the
kernel implementation of bootp.  Am I missing it somewhere?

b.

