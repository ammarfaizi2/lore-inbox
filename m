Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTCXXfG>; Mon, 24 Mar 2003 18:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbTCXXfG>; Mon, 24 Mar 2003 18:35:06 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:64952 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261292AbTCXXfA>; Mon, 24 Mar 2003 18:35:00 -0500
Subject: Re: CONFIG_VT_CONSOLE in 2.5.6x ?
From: Steven Cole <elenstev@mesatop.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Louis Garcia <louisg00@bellsouth.net>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030324233158.E10370@flint.arm.linux.org.uk>
References: <1048546447.3058.3.camel@tiger>
	<33453.4.64.238.61.1048547120.squirrel@www.osdl.org>
	<1048548310.3388.7.camel@tiger> 
	<20030324233158.E10370@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 24 Mar 2003 16:41:21 -0700
Message-Id: <1048549281.2464.87.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 16:31, Russell King wrote:
> On Mon, Mar 24, 2003 at 06:25:10PM -0500, Louis Garcia wrote:
> > Well I can't find it there. I have a 2.5.65 tree and under character
> > devices I have
> 
> you need:
> 
> CONFIG_INPUT=y
> 
> to allow the option you're looking for to show up.

And next time he can figure this out himself looking at
drivers/char/Kconfig:

#
# Character device configuration
#

menu "Character devices"

config VT
        bool "Virtual terminal"
        requires INPUT=y

and just after that:

config VT_CONSOLE
        bool "Support for console on virtual terminal"
        depends on VT
 

Steven




