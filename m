Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135980AbRD0P41>; Fri, 27 Apr 2001 11:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135958AbRD0P4R>; Fri, 27 Apr 2001 11:56:17 -0400
Received: from www.linux.org.uk ([195.92.249.252]:52997 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S135980AbRD0P4D>;
	Fri, 27 Apr 2001 11:56:03 -0400
Date: Fri, 27 Apr 2001 16:55:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Subba Rao <subba9@home.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: init process in 2.2.19
Message-ID: <20010427165558.B12256@flint.arm.linux.org.uk>
In-Reply-To: <20010426173016.C1125@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010426173016.C1125@home.com>; from subba9@home.com on Thu, Apr 26, 2001 at 05:30:16PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 05:30:16PM +0000, Subba Rao wrote:
> I am trying to add a process which is to be managed by init. I have added the
> following entry to /etc/inittab
> 
> SV:2345:respawn:env - PATH=/usr/local/bin:/usr/sbin:/usr/bin:/bin svscan /service </dev/null 2> dev/console
> 
> After saving, I execute the following command:
> 
> 	# kill -HUP 1
> 
> This does not start the process I have added. The process that I have added
> only starts when I do:

telinit q tells init to re-read the inittab, as per the telinit man page.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

