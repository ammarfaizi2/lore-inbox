Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTI2ILA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTI2ILA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:11:00 -0400
Received: from mail-02.iinet.net.au ([203.59.3.34]:13001 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262864AbTI2IK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:10:59 -0400
Subject: Re: Test6: still an error in 'make install'
From: Gawain Lynch <gawain@freda.homelinux.org>
To: reg@dwf.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200309290455.h8T4tVdd006356@orion.dwf.com>
References: <200309290455.h8T4tVdd006356@orion.dwf.com>
Content-Type: text/plain
Message-Id: <1064822686.2683.5.camel@frodo.felicity.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 29 Sep 2003 18:04:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 14:55, reg@dwf.com wrote:
[snip]
> sh /usr/src/linux-2.6.0-test6/arch/i386/boot/install.sh 2.6.0-test6 
> arch/i386/boot/bzImage System.map ""
> No module aic7xxx found for kernel 2.6.0-test6
> mkinitrd failed
[snip]

You most likely have a line like the following in you /etc/modules.conf
 
  alias scsi_hostadapter aic7xxx

and mkinitrd is being called without the --builtin= option by one of the
downstream scripts from install.sh (see above)

Gawain

