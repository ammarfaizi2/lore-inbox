Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbTC3OTA>; Sun, 30 Mar 2003 09:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbTC3OTA>; Sun, 30 Mar 2003 09:19:00 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:51469 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261309AbTC3OS7>;
	Sun, 30 Mar 2003 09:18:59 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jonathan Abbey <jonabbey@arlut.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre6: mmx_memcpy not properly exposed to modules with Athlon 
In-reply-to: Your message of "Sun, 30 Mar 2003 04:47:21 CST."
             <20030330104720.GA27518@arlut.utexas.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 Mar 2003 00:30:08 +1000
Message-ID: <22235.1049034608@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Mar 2003 04:47:21 -0600, 
Jonathan Abbey <jonabbey@arlut.utexas.edu> wrote:
>I've had a good deal of trouble this evening trying to compile
>2.4.21-pre6 for the Athlon processor.  It appears that when the
>kernel's bzImage is built all is well, but building modules (for USB)
>results in unresolved references to _mmx_memcpy in the modules.

To change cpu type -

save .config
make mrproper
restore .config
make menuconfig
make dep - in a separate step from make *config
make bzImage modules

Kernel build gets confused by changing cpu type, especially if you
make *config dep as one command.
