Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUKWBmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUKWBmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKWBlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:41:55 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:7491 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262530AbUKWBle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:41:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aiY8dWX6Kg4Z+qZtDBP714BeTWuUWKfU9yco/3jBmyaIwpfEfDGJ8RqmwlcKgmkPSjQqnIJy1rQYQw13YzsJx2R81u0/nfVxfsmRcv/gjgFWVTiGuFodz5uJnOZ7+pGu8hNZH22XnQ2RNOF1fsqcrzx3Tcx/ANZfjYBdu4Ue2kw=
Message-ID: <1c8c9de30411221741a80ccd0@mail.gmail.com>
Date: Mon, 22 Nov 2004 22:41:23 -0300
From: Javier Echaiz <jechaiz@gmail.com>
Reply-To: Javier Echaiz <jechaiz@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Strange ssh hang with kernel 2.6.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41A25AC5.7040402@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411221007.47237.garcia@iwr.fzk.de> <41A25AC5.7040402@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested it on 2.6.9-ac10 and there are no problems here
(Slackware-current)... I have udev and devfs though.

BTW: i have the line
KERNEL="tty[p-za-e][0-9a-f]*", NAME="pty/s%n", SYMLINK="%k"
in my /etc/udev/rules.d/udev.rules (don't know if this will fix your
problem, but i hope so! :). I changed this line (originally
NAME="tty/s%n") to fix my not working /usr/bin/less.

On Mon, 22 Nov 2004 16:31:49 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> Ariel Garcia wrote:
> 
> 
> > Hi,
> >
> > after i upgraded to  2.6.9 (from 2.6.8-rc4), I started having a similar
> > problem to the one somebody else reported on Oct. 27 (thread "SSH and
> > 2.6.9"), namely my ssh client hanging soon after doing some cat to
> > screen...
> > Actually, dissabling CONFIG_LEGACY_PTYS, or SOFTWARE_SUSPEND does not
> >  solve the problem for me.
