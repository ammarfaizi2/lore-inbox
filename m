Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137201AbREKSit>; Fri, 11 May 2001 14:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137203AbREKSij>; Fri, 11 May 2001 14:38:39 -0400
Received: from www.linux.org.uk ([195.92.249.252]:5124 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S137201AbREKSif>;
	Fri, 11 May 2001 14:38:35 -0400
Date: Fri, 11 May 2001 19:38:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Brian J. Murrell" <brian@mountainviewdata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip autoconfig with modules, kernel 2.4
Message-ID: <20010511193833.B12798@flint.arm.linux.org.uk>
In-Reply-To: <20010510094953.C28095@brian-laptop.us.mvd> <20010510180039.D9771@flint.arm.linux.org.uk> <20010511111300.A27378@brian-laptop.us.mvd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010511111300.A27378@brian-laptop.us.mvd>; from brian@mountainviewdata.com on Fri, May 11, 2001 at 11:13:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 11:13:00AM -0700, Brian J. Murrell wrote:
> I should have given more information though.  My goal is actually to
> NFSRoot the machine being booted.  I could not determine a way to get
> the "root path" attribute given by the dhcp/bootp server from
> userspace back to the kernel so that it can
> "change_root()/mount_root()" with it.  I seem to recall there was a
> proc interface for doing this at one time (in the 2.2 kernel) but it
> seemed to have went away.

As long as you can get the root server IP and path from the DHCP client,
then you mount it in a directory, and use pivot_root() to change to
that directory.

See the "Changing the root device" of Documentation/initrd.txt for more
information about this.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

