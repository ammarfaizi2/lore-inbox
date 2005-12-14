Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVLNW5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVLNW5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbVLNW5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:57:20 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:59801 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965035AbVLNW5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:57:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W/zZGMF1eBecxGPKDApDlc6oVyU/0P4I2DOdUbKsBcReI4CS1xddUrUIfcF2/hXnSBVCbno1uKu15ULaM1DKievjY+LGy2pzbgCTYCD3AF6l3HdMxu3MRxv2DV+H+8EDrImdBZpv4wsqJlRN9NZDHjBMOCo3uHtlM/rxK8VUP18=
Message-ID: <9a8748490512141457g453178b4w5ab8537041fc3277@mail.gmail.com>
Date: Wed, 14 Dec 2005 23:57:18 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 3/3] [kconfig] Direct use of lxdialog routines by menuconfig
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org, sam@ravnborg.org,
       kbuild-devel@lists.sourceforge.net
In-Reply-To: <20051212004606.31263.37616.stgit@machine.or.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051212004159.31263.89669.stgit@machine.or.cz>
	 <20051212004606.31263.37616.stgit@machine.or.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/05, Petr Baudis <pasky@suse.cz> wrote:
> After three years, the zombie walks again!  This patch (against the latest
> git tree) cleans up interaction between kconfig's mconf (menuconfig
> frontend) and lxdialog. Its commandline interface disappears in this patch,
> instead a .so is packed from the lxdialog objects and the relevant
> functions are called directly from mconf.
>
> In practice, this means that drawing on the screen is done with _MUCH_
> less overhead now, the screen updates are better optimalized as ncurses
> won't get reset everytime you display something, that also implies that
> the ugly screen flickering is done. As a cute side-effect, the dialogs
> are now rendered on the top of the menu or help panel.  In the future,
> this also gives us much more freedom for enhancing the user interface.
>
> This opens space for plenty of cleanups of liblxdialog, removal of
> superfluous stuff and temporary files usage, etc.
>
> Compared to the previous version (from February 2003), this one should be
> less buggy (especially wrt. the escape character handling), should not
> crash while resizing and the resizing should have immediate effect
> (although things can still start looking ugly when you are resizing while
> not in a menu - to fix that properly, more liblxdialog integration is
> required). Also, the code is considerably simplified on few places.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>

I just gave it a very quick spin and I like it. Very nice.

It's definately a lot snappier, nice work.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
