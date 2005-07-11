Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVGKM2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVGKM2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 08:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVGKM2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 08:28:54 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:30435 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261661AbVGKM2l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 08:28:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cyEsx1mp5PMa1afLvjHgN14YUmjH2gMc1/cH5Z5nHNLNVQUvA60rXGZvQkJ3H9nhZjy5ZV5QvkLUIRMWzslHKDK9W5lFCYLWRhBKW1yca89nAqM1LnUJZ+/BnWMT8xDbb1fiRT5H8V5y2inYYcJwMsmWbvl/dOsbWLZofOloLyc=
Message-ID: <31d23c690507110528468aff8b@mail.gmail.com>
Date: Mon, 11 Jul 2005 14:28:35 +0200
From: Jaroslav Soltys <jaro.soltys@gmail.com>
Reply-To: Jaroslav Soltys <jaro.soltys@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
In-Reply-To: <42D06531.9060903@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050630153738.GU11013@nysv.org>
	 <200506301952.j5UJqPrn013513@laptop11.inf.utfsm.cl>
	 <87wto5yo9o.fsf@evinrude.uhoreg.ca> <42D06531.9060903@stesmi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So basically if I write a program that works in both Gnome and KDE
> I should (according to your description) implement my own VFS that
> will use the Gnome or KDE VFS that will then use the OS VFS.
> 
> Is it only me finding that a little silly?

Maybe. Advantages of kde/gnome/other userland vfs ? Authentication
when using SMB shares, transparent access to fish/webdav/ftp/... but
only for applications that use these libraries. Maybe patched
automount together with lufs plus some GUI for acquiring user
credentials from kde/gnome user could do the same, but kde/gnome vfs
is portable to other unices.

Oh, by the way... mount something with smbmount and turn of that
computer you mounted the share from. You must switch to root to be
able to do umount -lf. But yes, I agree with you, it is silly and I
would also like to have one good solution than two average ones.

> I mean, if I am to have the same functionality under neither Gnome
> nor VFS and they don't support something I need I _NEED_ a vfs so
> that my program is so totally independent on anything at all.

right, wouldn't it be nice to 'cd /mnt/webdav/' or
'/mnt/ssh/infernal.machine/' in bash ? :)

> My program calling My VFS which calls KDE/Gnome's VFS which calls the OS
> VFS will be slowe than just calling the VFS immidiately - I do hope you
> can see that.

Some of kde/gnome vfs are not even filesystems at all, this is the
main advantage of userland vfs. Imagine that it is possible for user
to add new FS to kde/gnome, is it possible for him to add it to kernel
without root access ? compile new module and load it ? (Un)fortunately
not.

jaro
