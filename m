Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUHVWRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUHVWRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 18:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267610AbUHVWRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 18:17:43 -0400
Received: from ee.oulu.fi ([130.231.61.23]:23499 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S267607AbUHVWRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 18:17:38 -0400
Date: Mon, 23 Aug 2004 01:17:34 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: linux-kernel@vger.kernel.org
Cc: bruceg@em.ca
Subject: Re: Broadcom 4401 problem
Message-ID: <20040822221734.GA10372@ee.oulu.fi>
References: <20040822205346.GA17895@em.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040822205346.GA17895@em.ca>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 02:53:46PM -0600, Bruce Guenter wrote:
> Greetings.
> 
> I have a Dell Inspiron 1150 laptop which has a built-in Broadcom 4401
> NIC.  I am using Gentoo's 2.6.8.1 kernel and the built-in b44 driver.
> It compiles, loads, and I can get basic network traffic through it just
> fine.  However, it (the NIC) locks up randomly when I try to do bulk
> data transfers (with rsync for example).  I can get it to reset itself
> 
> Is this likely a hardware problem, or a problem in the driver?
Hiya

Could you try the driver from http://www.ee.oulu.fi/~pp/b44-095-2.tgz ,
which has some fixes that have been submitted but not yet merged. If that
doesn't help, the broadcom driver 
( http://www.broadcom.com/drivers/downloaddrivers.php ) might be
worth a try.

Also if you have more than 1Gb of memory, booting with mem=1024m 
might help (although with standard kernels with a 3:1
memory layout this hardware bug shouldn't get triggered and the typical
symptom is a complete hang). But it's worth a try in any case.
The updated driver mentioned above contains a workaround, so this shouldn't 
be needed anymore in any case.

Anyway, please report whether any of this helped. 
-- 
Pekka Pietikainen
