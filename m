Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUJZRH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUJZRH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUJZRH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:07:59 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:50139 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261351AbUJZRHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:07:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=j09lUfUdFgMvkmkK7QTDrPa11lyWuV0brEWyCeyafyvmVQwsDzSwskxr2n47dWls7v9nRSub6QCPwBs0znD5N4BrKJXiKH6WsjCg12Pw8WlnrQ4SJfJfpl1EY2UQGmXHGTmrrT+2JYNopJDp5i3goOmkEeihYlnx05xRjMpFJd4=
Message-ID: <58cb370e0410261007145fc22c@mail.gmail.com>
Date: Tue, 26 Oct 2004 19:07:45 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mathieu Segaud <matt@minas-morgul.org>
Subject: Re: 2.6.9-mm1: LVM stopped working
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e041026070067daa404@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <87oeitdogw.fsf@barad-dur.crans.org>
	 <58cb370e041026070067daa404@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 16:00:47 +0200, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Sun, 24 Oct 2004 01:06:07 +0200, Mathieu Segaud
> <matt@minas-morgul.org> wrote:
> >
> > Well, I gave a try to last -mm tree. The bot seemed good till it got to
> > LVM stuff. Vgchange does not find any volume groups. I can't say much because
> > lvm is pretty "early stuff" on this box; so it is pretty unusable. All I know
> > for now, as I changed a little my boot scripts to be more verbose, is that
> > vgchange -avvv y returns this kind of message:
> > hdXN: cannot read LABEL
> > and this message for all parts it can test....
> > As I need this box up and running, I came back to 2.6.9-rc3-mm3 (it works
> > pretty well). I will be able to run more tests on it, tomorrow but for now
> > that's all I can provide.
> >
> > Oh and dmesg didn't have any oops or BUG in it, and seemed quite usual,
> > in IDE detection and settings messages and device-mapper messages.
> >
> > However, I use dm-crypt to encrypt my / (no initrd, just initramfs) and
> > it works under 2.6.9-mm1, so the bug is likely to be in IDE stuff.
> 
> prove it ;)

To make this task easier I prepared 2.6.9-rc3-mm3 to 2.6.9-mm1 IDE patch:

http://home.elka.pw.edu.pl/~bzolnier/ide-2.6.9-rc3-mm3-to-2.6.9-mm1.patch.bz2

Just revert it from 2.6.9-mm1.

> There were only minor IDE changes from 2.6.9-rc3-mm3 to 2.6.9-mm1,
> I don't see any obvious suspects...
