Return-Path: <linux-kernel-owner+w=401wt.eu-S932099AbXARJJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbXARJJt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbXARJJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:09:48 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2266 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbXARJJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:09:45 -0500
Date: Thu, 18 Jan 2007 09:09:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Seetharam Dharmosoth <seetharam_kernel@yahoo.co.in>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: query related to serial console
Message-ID: <20070118090935.GA32068@flint.arm.linux.org.uk>
Mail-Followup-To: Seetharam Dharmosoth <seetharam_kernel@yahoo.co.in>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	linux-kernel@vger.kernel.org
References: <20070117203421.6d80be93.randy.dunlap@oracle.com> <526190.52452.qm@web7704.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526190.52452.qm@web7704.mail.in.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 05:39:15AM +0000, Seetharam Dharmosoth wrote:
> I have one doubt in this regard.
> 1) once we connected to the serial console we don't
>    want to login into the shell.
>    (without login into the shell we want to fire the
>    sysrq command like b, r m, etc.)
> 
>  for this I am doing like 
>   grabing the serial console then
>   doing ctrl+]
>   so that getting 
>               telnet> 
> now i want to give command like b, m ,r etc.
> 
> but it is not accepting my commands until I do 
> telnet> send brk
> 
> can you please explain me why like this behavior ?

If it didn't require a break before hand, merely pressing 'b', 'm' or 'r'
would trigger the sysrq command, which would make it absolutely impossible
to login or type any normal command containing those characters.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
