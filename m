Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWG2O3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWG2O3p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 10:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWG2O3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 10:29:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:50625 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751370AbWG2O3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 10:29:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=juIAGTBdTEgs2EL+psWqtdze4of6waSP24kXu3h8HUDo363SMflhnQXE/Jje8t8Ibg4wgyvBiKBAiyDMCwfoQZtvM3qw9/s56YKQ/uPw9zTkYWA5DsIOycvQlkz2hC0fhFKO6JeORMT6Klwu33IAS3vx5KF+IcwYIpD8B5QGIQ8=
Message-ID: <9a8748490607290729y49c66208n8b8ea5b9b29a3d06@mail.gmail.com>
Date: Sat, 29 Jul 2006 16:29:42 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Brian D. McGrew" <brian@visionpro.com>
Subject: Re: Building the kernel on an SMP box?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_26390_2387763.1154183382737"
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_26390_2387763.1154183382737
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 27/07/06, Brian D. McGrew <brian@visionpro.com> wrote:
> Good morning all!
>
> Currently I'm building my kernels on a Dell PE 1800 3.0GHz.  My dilemma
> is that I build and rebuild the kernel about twenty times a day and even
> though it only takes about 20 minutes, that's rapidly becoming too slow!
> Today it's the 2.6.17 kernel on FC5 that I'm building with.
>
> I see all these blurbs out there about someone being able to build a
> complete kernel in under a minute or running an SMP build across
> multiple CPUS and/or multiple machines.
>
> So, to ask the group that should know the best ... What would be a
> reasonable configuration to get my builds down under five minutes or so?

My box builds my ordinary .config (attached) in under 5min :

$ time make -j3
real    3m58.047s
user    4m54.574s
sys     1m24.202s

Here are some more numbers for you to compare to your box :

allnoconfig :

$ make clean
$ make allnoconfig
$ time make -j3
real    0m54.544s
user    1m2.113s
sys     0m20.781s


allmodconfig :

$ make clean
$ make allmodconfig
$ time make -j3
real    28m49.748s
user    35m3.212s
sys     10m43.633s


This box uses a Athlon64 X2 4400+ CPU, has 2GB RAM and a single
Ultra160 SCSI disk.
It's currently running an i386 kernel, not x86_64, so it's probably
not performing to it's full potential atm.


> And then to go to the extreme, what kind of horsepower should I be
> looking for if I want get the build times down to say a minute or so???
>
Make sure you have a fast disk and adequate amounts of RAM so you
don't end up swapping, then add more CPU's.
A dual-core box is not too expensive these days and an additional core
really speeds things up. If you have the money for it, then a box with
two dual-core CPU's is ofcourse even better.
If you have several machines, then you can use distcc
(http://distcc.samba.org/) to distribute the build across the boxes -
that's an easy way to speed things up if you have a bunch of older
computers lying around.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_26390_2387763.1154183382737
Content-Type: application/x-gzip; name=.config.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eq82lhw2
Content-Disposition: attachment; filename=".config.gz"

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
Sn9E7pKQQK/6P0tt+I4BcgAA
------=_Part_26390_2387763.1154183382737--
