Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945921AbWBCW3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945921AbWBCW3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946010AbWBCW3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:29:04 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:33540 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1945921AbWBCW3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:29:03 -0500
Date: Fri, 3 Feb 2006 23:28:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Fr?d?ric L. W. Meunier" <2@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: menuconfig: no colors in 2.6.12-rc2 ?
Message-ID: <20060203222843.GA11973@mars.ravnborg.org>
References: <Pine.LNX.4.64.0602031957070.4864@dyndns.pervalidus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602031957070.4864@dyndns.pervalidus.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 08:15:54PM -0200, Fr?d?ric L. W. Meunier wrote:
> 2.6.15's menuconfig has colors, but 2.6.12-rc2 doesn't have. At 
> least here...
ncursesw is now first choice.
What does following command print:

gcc -print-file-name=libncursesw.so

If it prints just libncursesw.so then this is not the issue.
But if it prints a full path similar to:
/usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib64/libncursesw.so
then this may be the case.

Try to rename ncursesw to ncurses in
scripts/kconfig/lxdialog/check-dialog.sh
to test if ncursesw is the culprint.

Thanks,
	Sam
