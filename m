Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUDJOf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUDJOf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 10:35:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3083 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262041AbUDJOfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 10:35:23 -0400
Date: Sat, 10 Apr 2004 15:35:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Force build error on undefined symbols
Message-ID: <20040410153519.C4221@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040410131028.A4221@flint.arm.linux.org.uk> <20040410142401.GA2439@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040410142401.GA2439@mars.ravnborg.org>; from sam@ravnborg.org on Sat, Apr 10, 2004 at 04:24:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 04:24:01PM +0200, Sam Ravnborg wrote:
> > 
> > Therefore, I propose the following patch to detect undefined symbols
> > in the final image and force an error if this is the case.
> > 
> > Comments?
> 
> Do we really want to do this for all architectures?
> You could use something like the attached to restrict it to arm.

Unfortunately, some people got it into their heads to use the top
level vmlinux directly, so this wouldn't always catch the problem.
It really needs to be done immediately after vmlinux is generated
to ensure that all cases are caught.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
