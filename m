Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266551AbUGPNeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266551AbUGPNeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 09:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUGPNeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 09:34:36 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:57229 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S266551AbUGPNef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 09:34:35 -0400
Date: Fri, 16 Jul 2004 15:34:32 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Generic patching instruction to fix inline bugs with gcc-3.4?
Message-ID: <20040716133432.GD4328@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a generic approach to fix issues like this that happen when
trying to build with gcc-3.4:

> With gcc-3.4 I get:
> 
> make[1]: Entering directory /usr/src/linux-2.6.8-rc1-mm1'
> make[2]: arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>     CC      drivers/net/8139too.o
>     drivers/net/8139too.c: In function rtl8139_open':
>     drivers/net/8139too.c:616: sorry, unimplemented: inlining failed
> in call to 'rtl8139_start_thread': function body not available
> drivers/net/8139too.c:1362: sorry, unimplemented: called from here
> make[3]: *** [drivers/net/8139too.o] Error 1
> make[2]: *** [drivers/net] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory /usr/src/linux-2.6.8-rc1-mm1'
> make: *** [stamp-build] Error 2

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
