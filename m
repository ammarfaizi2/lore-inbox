Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWFBSBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWFBSBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWFBSBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:01:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:13815 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932522AbWFBSBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:01:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=M/gBFyNH6/ywsiJ8xaLlo0J252vtTUYhVFST3c0bfBCZNxCKFuaxqsNCYUioyOmYLPqrFyWNhwV/AkTNIe54qkZ1u+sp/OIIOSvXVPlVOTURTFGCZ9HjA6cfwXdqVuXfgvKijo6ZYapHluWX9jap4kBMcukxKpAukhqLPp8vZFg=
Message-ID: <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com>
Date: Fri, 2 Jun 2006 11:01:14 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060602142009.GA10236@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
	 <20060601183836.d318950e.akpm@osdl.org>
	 <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
	 <20060602142009.GA10236@elte.hu>
X-Google-Sender-Auth: ab2c38b986530ee4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/06, Ingo Molnar <mingo@elte.hu> wrote:
> ok. I forgot to mention that it's probably a good idea to first apply
> my lockdep-combo patch to -mm2:
>
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm2.patch
>
> this includes all current -mm hotfixes and all lockdep fixes. (The
> lockdep tracer patch will still apply cleanly ontop of the combo patch.)

Actually, I noticed that the tracer patch applied with fewer offsets
(i.e. "more cleanly," in a sense) with the lockdep-combo patch applied
first, so I did that.

I'm doing building the kernel, but I haven't been able to boot it yet:
This system boots the kernel off floppy disks, and under
2.6.17-rc5-mm2, the floppy drive no longer works! The disk spins but
the kernel can't read any of the disk's sectors, even for other
known-working floppies. I'll have to boot back into 2.6.17-rc4-mm3
before I can copy the new kernel onto a disk and boot from it. That
will take me a couple of minutes, although I have to go to school in
under an hour so I might not get to it until later today.

Oh, wait, let me try a sadistic experiment first: Let's see if I can
format a floppy disk with the floppy drive in this non-functioning
state... no, "/dev/fd0: Read-only file system", 100% reproducible.
-- 
-Barry K. Nathan <barryn@pobox.com>
