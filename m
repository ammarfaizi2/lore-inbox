Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284948AbRLKKIz>; Tue, 11 Dec 2001 05:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284952AbRLKKIp>; Tue, 11 Dec 2001 05:08:45 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:33034 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284948AbRLKKId>; Tue, 11 Dec 2001 05:08:33 -0500
Date: Tue, 11 Dec 2001 10:08:03 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: gspujar@hss.hns.com
Cc: linux-kernel@vger.kernel.org, achowdhry@hss.hns.com
Subject: Re: software watchdog
Message-ID: <20011211100803.A3306@flint.arm.linux.org.uk>
In-Reply-To: <65256B1F.002BF453.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <65256B1F.002BF453.00@sandesh.hss.hns.com>; from gspujar@hss.hns.com on Tue, Dec 11, 2001 at 01:33:04PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 01:33:04PM +0530, gspujar@hss.hns.com wrote:
> >>>printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n"); prints the
> message on the console.
> 
> I put a delay of 5secs with mdelay, and I can see the message on the console.
> I wanted the message as a syslog,

In order to log this message to syslog, you need to allow the syslog
process to run.  If you're using a uniprocessor machine, using mdelay()
doesn't allow syslog to run during this time.

Softdog has a "testing" mode, which can be enabled by defining
ONLY_TESTING.  This disables the automatic reboot, but the system
will log the timeout message.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

