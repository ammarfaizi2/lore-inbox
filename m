Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282197AbRKWSDO>; Fri, 23 Nov 2001 13:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282198AbRKWSDF>; Fri, 23 Nov 2001 13:03:05 -0500
Received: from mta09-acc.tin.it ([212.216.176.40]:12954 "EHLO fep09-svc.tin.it")
	by vger.kernel.org with ESMTP id <S282197AbRKWSCy>;
	Fri, 23 Nov 2001 13:02:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Flavio Stanchina <flavio.stanchina@tin.it>
Organization: not at all
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't patch my 2.4.14 KERNEL!
Date: Fri, 23 Nov 2001 19:02:49 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <EXCH01SMTP01tFT0D7G00000f88@smtp.netcabo.pt>
In-Reply-To: <EXCH01SMTP01tFT0D7G00000f88@smtp.netcabo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011123180249.XGSD24552.fep09-svc.tin.it@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 November 2001 18:42, Miguel Maria Godinho de Matos wrote:

> i have the 2.4.14 kernel tree i downloaded from www.kernel.org site
> in my /usr/src/kernel-2.4.14
>
> and i have the  patch-2.4.15-pre9.gz patch in the /usr/src  ( as it is
> recomended in the kernel how to.
>
> i have done the following command:
>
> #zcat  patch-2.4.15-pre9.gz | patch -p0 ( as the example of the how to
> displays!!!! )

That's wrong. Either name the directory "linux" instead of "linux-2.4.14" 
(if you prefer, just create a symlink) or you have to do:

  cd /usr/src/linux-2.4.14
  zcat ../patch-2.4.15-pre9.gz | patch -p1

I would advise you against patching the original files; instead do 
something like this:

  cd /usr/src
  cp -al linux-2.4.14 linux-2.4.15-pre9
  cd linux-2.4.15-pre9
  zcat ../patch-2.4.15-pre9.gz | patch -p1

> By the way when is the linux kernel 2.4.15 comming out???

Yesterday.

-- 
Ciao,
    Flavio Stanchina
    Trento - Italy

"The best defense against logic is ignorance."
http://spazioweb.inwind.it/fstanchina/
