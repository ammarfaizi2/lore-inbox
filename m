Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTIIOEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbTIIOEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:04:47 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:40834 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264144AbTIIOEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:04:43 -0400
Subject: Re: Make Menuconfig and Make Xconfig errors in Mandrake 9.2 rc1
From: Steven Cole <elenstev@mesatop.com>
To: Anton Kholodenin <cicprogr@mail.dux.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000701c376ba$11e87ef0$370101c8@antontest>
References: <000701c376ba$11e87ef0$370101c8@antontest>
Content-Type: text/plain
Organization: 
Message-Id: <1063115985.1664.14.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 09 Sep 2003 07:59:45 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-09 at 04:06, Anton Kholodenin wrote:
> I find 2 errors in Mandrake 9.2 rc 1
> 
As others noted, a Mandrake-specific list is a better choice in this
instance, but the problem you noted below happens occasionally in 2.4
bleeding edge stuff, so I'm posting something for you to look for.
> 
> 2. If i do cd /usr/src/linux; make xconfig program not started and write to
> console:

Try something like this in your /usr/src/linux directory:

$ find . -name [Cc]onfig.in | xargs grep "'y'"
./drivers/char/Config.in:if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_SGI_SN2" = 'y' ] ; then

See the 'y' above?  That's a mistake in 2.4.23-pre3.  I don't have the
Mandrake 9.2rc1 kernel source, but you do, so find the bug and report it
to Mandrake. They most likely have this problem already fixed in cooker,
but at least you may be able to get your local system fixed.

There are other ways to cause make xconfig to fail as you described, but
this is one of the more common.

The Mandrake-cooker archive is here:
http://marc.theaimsgroup.com/?l=mandrake-cooker&r=1&b=200309&w=2

Steven




