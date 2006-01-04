Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWADBvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWADBvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWADBvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:51:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965153AbWADBvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:51:42 -0500
Date: Tue, 3 Jan 2006 17:51:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: snakebyte@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch] es7000 broken without acpi
Message-Id: <20060103175125.0013fe15.akpm@osdl.org>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B09AE@USRV-EXCH4.na.uis.unisys.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B09AE@USRV-EXCH4.na.uis.unisys.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com> wrote:
>
> > Eric Sesterhenn / snakebyte <snakebyte@gmx.de> wrote:
>  > >
>  > > hi,
>  > > 
>  > > a make randconfig gave me a situation where es7000 was enabled, but 
>  > > acpi wasnt ( dont know if this makes sense ), gcc gave me some 
>  > > compiling errors, which the following patch fixes. Please 
>  > cc me as i am not on the list. Thanks.
>  > > 
>  > > 
>  > 
>  > I believe that es7000 requires ACPI, so a better fix would be 
>  > to enforce that within Kconfig.
>  > 
>  > Natalie, can you please comment?
> 
> 
>  You are correct, Andrew: ES7000 "preferred" mode is ACPI (although it
>  runs in MPS as well, which we use for debugging of intermittent ACPI and
>  platform problems).
>  I have done a similar patch (see
>  http://bugzilla.kernel.org/attachment.cgi?id=5771&action=view) against
>  2.6.13, but the one suggested later by Peter Hagervall  
>  http://www.ussg.iu.edu/hypermail/linux/kernel/0510.3/1302.html was
>  actually taking care of the compile problem through Kconfig better,
>  since "acpi=off" option is available for our debug/testing purposes
>  anyway.

hm, OK.  I won't apply anything then - please send me your preferred fix if
you think there's something here which needs fixing.  Either way, we should
attempt to make the kernel compile with all possible configs, if only to
keep `make randconfig' testers happy ;)
