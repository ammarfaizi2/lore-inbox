Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTF2UIL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTF2UHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:07:38 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:23685 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264979AbTF2UGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:06:38 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 29 Jun 2003 13:19:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
In-Reply-To: <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.55.0306291317300.14949@bigblue.dev.mcafeelabs.com>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net>
 <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> I think that I will believe it when I see the patchset implementing it.
> Provided that it will be convincing enough.  Other than that...  Not
> really.  You will need code for each pair of filesystems, since
> convertor will need to know *both* layouts.  No amount of handwaving
> is likely to work around that.  And we have what, something between
> 10 and 20 local filesystems?  Have fun...
>
> If you want your idea to be considered seriously - take reiserfs code,
> take ext3 code, copy both to userland and put together a conversion
> between them.  Both ways.  That, by definition, is easier than doing
> it in kernel - you have the same code available and none of the limitations/
> interaction with other stuff.  When you have it working, well, time to
> see what extra PITA will come from making it coexist with other parts
> of kernel (and with much more poor runtime environment).
>
> AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
> If you can get it done - well, that might do a lot for having the
> idea considered seriously.  "Might" since you need to do it in a way
> that would survive transplantation into the kernel _and_ would scale
> better that O((number of filesystem types)^2).

Maybe defining a "neutral" metadata export/import might help in limiting
such NFS^2 ...



- Davide

