Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWCaBZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWCaBZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWCaBZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:25:32 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:44435 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751020AbWCaBZc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:25:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ufCr6OO+W9NrTgV9Q0BM53SeeczD8xsSDl3dbLGhZ6agOA1/fwsPM9zHuT0qhAVHcQfM9VEfwIEk9oCPojCxi51xDDVYNUQvz1DWS5967sJVQanKeqQ7gUacYbhLnm9HpJxsdOGMHMwpuHOSRPaiNXNs07I5K8oxSgrg41yopZA=
Message-ID: <1458d9610603301725r127cc73djb125ae56c992cb99@mail.gmail.com>
Date: Fri, 31 Mar 2006 09:25:30 +0800
From: "Sumit Narayan" <talk2sumit@gmail.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Subject: Re: cannot get clean 2.4.20 kernel to compile
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "George P Nychis" <gnychis@cmu.edu>
In-Reply-To: <442C81BC.7030605@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5W8lY-1wF-29@gated-at.bofh.it> <442C81BC.7030605@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the error output 1, it appears that your directory include/asm is
not a link to include/linux. Can you check that?

Otherwise, simply delete the directory include/asm and re-compile the
kernel from start; it should work.

-- Sumit



On 3/31/06, Robert Hancock <hancockr@shaw.ca> wrote:
> George P Nychis wrote:
> > Hi,
> >
> > I have downloaded the 2.4.20 kernel from ftp.kernel.org, have checked its sign, and no matter what I try I cannot get it to compile.
> >
> > I do a make mrproper, I then do make dep which is fine, but then i try "make bzImage modules modules_install", selecting all the defaults, and get an SMP header error:
> > http://rafb.net/paste/results/QzIq7v86.html
> >
> > I then disable SMP support and get:
> > http://rafb.net/paste/results/muYA9t12.html
> >
> > I even tried using my config from the 2.4.32 kernel which works perfectly fine, and I also get the sched errors.
>
> What gcc version? Some old kernels might not be buildable with newer
> compilers.
>
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
