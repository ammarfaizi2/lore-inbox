Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264156AbTCXQar>; Mon, 24 Mar 2003 11:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264263AbTCXQaq>; Mon, 24 Mar 2003 11:30:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12039 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264156AbTCXQap>; Mon, 24 Mar 2003 11:30:45 -0500
Date: Mon, 24 Mar 2003 16:41:51 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Spang Oliver <oliver.spang@siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/serial/Makefile
Message-ID: <20030324164151.C10370@flint.arm.linux.org.uk>
Mail-Followup-To: Spang Oliver <oliver.spang@siemens.com>,
	linux-kernel@vger.kernel.org
References: <AEEEEE93AFA5D411AF8500D0B75E4A16062A4677@BSL203E>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <AEEEEE93AFA5D411AF8500D0B75E4A16062A4677@BSL203E>; from oliver.spang@siemens.com on Mon, Mar 24, 2003 at 05:33:44PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 05:33:44PM +0100, Spang Oliver wrote:
> Do you have some other hints for the problem described in the
> "2.5.64 ttyS problem ?"-thread?

First line of attack would be to strace minicom and find out why it's
failing.

There are a few reasons why I think the kernel isn't to blame:

- I run minicom against the new serial subsystem fairly frequently, and
  haven't noticed any oddities like the reported problem.
- The core.c/8250.c drivers don't have very much to do with serial device
  locking - serial devices are locked by creating a file in /var/lock
  with a name corresponding to the device name being opened.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

