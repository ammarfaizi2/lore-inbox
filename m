Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbQKGPTs>; Tue, 7 Nov 2000 10:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130360AbQKGPTi>; Tue, 7 Nov 2000 10:19:38 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:19716 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129756AbQKGPTS>;
	Tue, 7 Nov 2000 10:19:18 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "Tue, 07 Nov 2000 11:47:57 -0300."
             <200011071447.eA7Elvw30830@pincoya.inf.utfsm.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 02:19:10 +1100
Message-ID: <14576.973610350@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000 11:47:57 -0300, 
Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>Keith Owens <kaos@ocs.com.au> said:
>> It makes no sense to allow duplicate module names in the same kernel
>> tree.  "modprobe foo" - which one gets loaded?
>
>Why the tree then?

Mainly so you can "modprobe -t net \*" and load all modules with /net/
in their pathname.  pcmcia modules need to be identified and linked.
mkinitrd also needs paths to identify scsi modules.  The old system of
assigning pathnames was manual, fragile and error prone, copying the
kernel tree works.  But whether modules are a flat directory, a
manually built two level directory or a copy of the kernel tree, it
still makes no sense to have duplicate names in the same kernel tree.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
