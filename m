Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVGPKME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVGPKME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 06:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVGPKME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 06:12:04 -0400
Received: from web32014.mail.mud.yahoo.com ([68.142.207.111]:24708 "HELO
	web32014.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261390AbVGPKMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 06:12:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gpDNkVb7wTMHBDjdZewj7B7XsLLCddBQhggchih1pRXzZx1H17ndJ+c6eLUL+ortvgFPDRyUD52F+FNydwunLzD2r+8Q/UjNPKk47Ixe3pXJ3GXyWY3isLZJJOTKZeDd091mbuLNWv54WH0cvZFjjdq8M7BUFm6wB0fgcj+YtmE=  ;
Message-ID: <20050716101201.46965.qmail@web32014.mail.mud.yahoo.com>
Date: Sat, 16 Jul 2005 03:12:01 -0700 (PDT)
From: Sam Song <samlinuxkernel@yahoo.com>
Subject: Re: [patch 2.6.13-git] 8250 tweaks
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: mgreer@mvista.com, david-b@pacbell.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050716094359.B19067@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> but it's not.  We need PPC folk to fix their
> SERIAL_PORT_DFNS and remove obsolete stuff like 
> RS_TABLE_SIZE.

Hope Mark could take care this change. I have no
sandpoint board at hand:-)

I removed RS_TABLE_SIZE on my target successfully
and happened to found that there was other file like
../syslib/gen550_dbg.c required SERIAL_PORT_DFNS 
as well which could use for KGDB or sth.

> Ideally, SERIAL_PORT_DFNS should end up being
> completely empty.

It has implemented on my target:-)

Still one puzzle related serial port. That's interrupt
itself. I enabled two serial ports attached two 
different interrupt levels like 9/10 with disable 
interrupt shared. How come only one appeared 
in /proc/interrupts? What could be on your platform
or they should be?

Thanks a lot,

Sam

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
