Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTAOJvL>; Wed, 15 Jan 2003 04:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTAOJvL>; Wed, 15 Jan 2003 04:51:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47375 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266064AbTAOJvK>; Wed, 15 Jan 2003 04:51:10 -0500
Date: Wed, 15 Jan 2003 10:00:01 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add module reference to struct tty_driver
Message-ID: <20030115100001.D31372@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030113054708.GA3604@kroah.com> <20030114200719.B4077@flint.arm.linux.org.uk> <20030114220859.GA17226@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114220859.GA17226@kroah.com>; from greg@kroah.com on Tue, Jan 14, 2003 at 02:08:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 02:08:59PM -0800, Greg KH wrote:
> Woah!  Hm, this is going to cause lots of problems in drivers that have
> been assuming that the BKL is grabbed during module unload, and during
> open().  Hm, time to just fallback on the argument, "module unloading is
> unsafe" :(

Note that its the same in 2.4 as well.  iirc, the BKL was removed from
module loading/unloading sometime in the 2.3 timeline.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

