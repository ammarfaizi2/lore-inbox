Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTDGUoL (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTDGUoL (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:44:11 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:15110 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S263633AbTDGUoK convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:44:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Date: Mon, 7 Apr 2003 22:55:47 +0200
User-Agent: KMail/1.4.3
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <b6qruf$elf$1@cesium.transmeta.com>
In-Reply-To: <b6qruf$elf$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304072255.47254.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 05:39, H. Peter Anvin wrote:
> Followup to:
> <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> By
> author:    Mark Grosberg <mark@nolab.conman.org>
> In newsgroup: linux.dev.kernel
>
> > > > Suppose I give you an O_RDONLY handle to a file which you then
> > > > flink and gain write access too ?
> > >
> > > This, I believe, is the real issue.  However, we already have that
> > > problem:
> >
> > As far as I understand it, isn't the protection information stored in the
> > inode? The flink call is just linking an inode into a directory that the
> > caller has write access to. The permissions and ownership of the file
> > shouldn't change.
>
> The problem is when you get passed a file descriptor from another
> process (via exec or file-descriptor passing) and you don't have
> permissions to access the *directory*.

Does that really matter? If the user owning the process has write permission
to the file, it can't possibly hurt security that he gains write access as
well to it using flink, right?
If it would prove to be a security hole anyway, it should be easily remedied
by only allowing the call for the file's owner and root. It would admittedly
make the call less usable, but its main uses still remain, as I see it.

Anyway, while we're on the subject, is it just me who would like to see a
fexec() call?

Fredrik Tolf

