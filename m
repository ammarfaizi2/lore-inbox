Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWJDUu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWJDUu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWJDUu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:50:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:45195 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751109AbWJDUu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:50:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i/1GczeGaW/QgZTKw7pRaOLH6frb636aiwYNFSLtnX2WggjCxXI+v555GtshN+i5ZAABpbWPdfav/mAvLckB/vTC7FRZcJ3WNm9Bm8JHKoNth9AzZZNA7NIINvXyykMdvepwBnJ4N3q+ln/EaY7638odDR+Qa5FERObgEFyx3tQ=
Message-ID: <5a4c581d0610041350m40fbf75dj724ef5d9e0d12025@mail.gmail.com>
Date: Wed, 4 Oct 2006 22:50:26 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: removed sysctl system call - documentation and timeline
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Hi,
>
> With recent kernels I'm getting a lot of warnings about programs using
> the removed sysctl syscal.
>
> Examples (after 5 min of uptime here) :
> root@dragon:/home/juhl# dmesg | grep "used the removed sysctl system
> call" | sort | uniq
> warning: process `dd' used the removed sysctl system call
> warning: process `ls' used the removed sysctl system call
> warning: process `touch' used the removed sysctl system call
>
> and more can be found...
>
>
> I'm not, as such, opposed to removing sysctl (and yes, I know what it
> is and what it does). What I am a little opposed to is that it is
> being removed on such short notice (unless I missed the memo) and that
> it is hidden inside EMBEDDED.
>
> I would like to propose that, at least for 2.6.19, it be default on
> (as it is now), not hide it in EMBEDDED where people usually don't go,
> some huge deprecation warnings be added, and that it then gets the
> usual 6-12months before being removed (did it already get that and I'm
> just slow?)...  ohhh, and correct the help text; it currently says
> "...Nothing has been using the binary sysctl interface for some time
> now so nothing should break if you disable sysctl syscall support" -
> that's obviously false as demonstrated by the above extract from my
> dmesg...

Another data point then... this is FC5-uptodate:

[asuardi@sandman incoming]$ dmesg | grep -i sysctl
warning: process `date' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `salsa' used the removed sysctl system call

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
