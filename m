Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVJBL5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVJBL5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 07:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVJBL5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 07:57:36 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:2160 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751082AbVJBL5g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 07:57:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d9c9aJrpwG7GFprbRNs2PlKCTI6vEjHRb0VfzsnxyCB1RKvg9+i8DNx6Ph+wDwilrbU19wN7RrXGGLELt3ZLf7ME0A3bhzlOqGcOGhVAM1xKQ71otrBcXKumJ7mOKmgHsMzz6W9UCyXgCkGhlvuxzahHJ64KZp3QwpJBJCen6Po=
Message-ID: <6880bed30510020457l49454b45s894ab314ba10be3f@mail.gmail.com>
Date: Sun, 2 Oct 2005 13:57:35 +0200
From: Bas Westerbaan <bas.westerbaan@gmail.com>
Reply-To: Bas Westerbaan <bas.westerbaan@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Why no XML in the Kernel?
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <433FB863.5070009@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	 <433FAD57.7090106@yahoo.com.au> <433FBE59.8000806@superbug.co.uk>
	 <433FB863.5070009@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

 In case /proc or /sys wouldn't be preffered, a simple key value
binary format would do.

 First a key/value pair count. Followed by the key/value pairs, which
consist out of the value and key prefixed by their size.

 Your user and kernel code could ignore keys they don't regognize.

 A better way though, is negotiate what types of structures to pass.

 The user space program would support all previous version of the kernel module.

  Bas

On 10/2/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> James Courtier-Dutton wrote:
>
> > I have a requirement to pass information from the kernel to user space.
> > The information is passed fairly rarely, but over time extra parameters
> > are added. At the moment we just use a struct, but that means that the
> > kernel and the userspace app have to both keep in step. If something
> > like XML was used, we could implement new parameters in the kernel, and
> > the user space could just ignore them, until the user space is upgraded.
> > XML would initially seem a good idea for this, but are there any methods
> > currently used in the kernel that could handle these parameter changes
> > over time.
> >
> > For example, should the sysfs be used for this?
> >
> > Any comments?
> >
>
> Yes use sysfs (or procfs if the information is related to a process).
> Using ASCII text representation, and a single value per file is
> noramlly the preferred method to do this I think.
>
> Nick
>
> --
> SUSE Labs, Novell Inc.
>
>
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



--
Bas Westerbaan
http://blog.w-nz.com/
GPG Public Keys: http://w-nz.com/keys/bas.westerbaan.asc
