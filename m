Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWG2Syp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWG2Syp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 14:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWG2Syp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 14:54:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:46867 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751090AbWG2Syp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 14:54:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qqdKeGt6bZQ8DASAaOyYO/FJAEXCiv34FKYx7S+K7XpX2xFqkSjmm+rtMon7GGlQwaOCmzHVKBXdxLX8F4X3HnO3gnjR+oIQcX7cM7wyP/OOGKjxOmq4u3dtpXfyicJcYz8NGGNcZof7s/M8KExmaCSZBbvGfQsJOi0r9t6jGjI=
Message-ID: <6de39a910607291154l5685bbb4nb78aa0689ca37986@mail.gmail.com>
Date: Sat, 29 Jul 2006 11:54:43 -0700
From: "Handle X" <xhandle@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: Building the kernel on an SMP box?
Cc: "Brian D. McGrew" <brian@visionpro.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490607290729y49c66208n8b8ea5b9b29a3d06@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
	 <9a8748490607290729y49c66208n8b8ea5b9b29a3d06@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 27/07/06, Brian D. McGrew <brian@visionpro.com> wrote:
> > Good morning all!
> > reasonable configuration to get my builds down under five minutes or so?
I got a (moderately old) Sun V20z with 2 Opteron 2.2 GHz with 7G ram.
My numbers are comparable with yours. (I don't know if they are on the
lower side for such a h/w configuration)
>
> My box builds my ordinary .config (attached) in under 5min :
>
> $ time make -j3
> real    3m58.047s
> user    4m54.574s
> sys     1m24.202s
Mine is (with your configuration file, src updated with latest linus' tree,
[om@turyxsrv /home/src/linux-2.6]$  time make -j4
...snipped...
real    4m12.316s
user    5m12.600s
sys     0m37.742s

With stdout redirected, (It helps to save a minute or so )
[om@turyxsrv /home/src/linux-2.6]$ time make -j4  >>time.txt

real    3m23.504s
user    5m14.776s
sys     0m38.138s

>
> Here are some more numbers for you to compare to your box :
>
> allnoconfig :
>
> $ make clean
> $ make allnoconfig
> $ time make -j3
> real    0m54.544s
> user    1m2.113s
> sys     0m20.781s

[om@turyxsrv /home/src/linux-2.6]$ time make -j4 > allnoconfigtime.txt
real    0m43.399s
user    1m6.256s
sys     0m9.389s
>
>
> allmodconfig :
>
> $ make clean
> $ make allmodconfig
> $ time make -j3
> real    28m49.748s
> user    35m3.212s
> sys     10m43.633s

[om@turyxsrv /home/src/linux-2.6]$ time make -j4 > allmodconfigtime.txt
real    39m59.100s
user    34m16.857s
sys     4m36.697s
> This box uses a Athlon64 X2 4400+ CPU, has 2GB RAM and a single
> Ultra160 SCSI disk.

[root@turyxsrv ~]# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   2676 MB in  2.00 seconds = 1338.79 MB/sec
 Timing buffered disk reads:  184 MB in  3.02 seconds =  61.00 MB/sec
