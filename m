Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSIKBEH>; Tue, 10 Sep 2002 21:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSIKBEH>; Tue, 10 Sep 2002 21:04:07 -0400
Received: from magic.adaptec.com ([208.236.45.80]:5310 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id <S318253AbSIKBEH>;
	Tue, 10 Sep 2002 21:04:07 -0400
Date: Tue, 10 Sep 2002 19:07:58 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/pci,hamradio,scsi,aic7xxx,video,zorro clean and
 mrproper files 4/6
Message-ID: <9500000.1031706478@aslan.btc.adaptec.com>
In-Reply-To: <20020910230656.D18386@mars.ravnborg.org>
References: <20020910225530.A17094@mars.ravnborg.org>
 <20020910230656.D18386@mars.ravnborg.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, September 10, 2002 23:06:56 +0200 Sam Ravnborg
<sam@ravnborg.org> wrote:
 ..

> diff -Nru a/drivers/scsi/aic7xxx/Makefile b/drivers/scsi/aic7xxx/Makefile
> --- a/drivers/scsi/aic7xxx/Makefile	Tue Sep 10 22:37:55 2002
> +++ b/drivers/scsi/aic7xxx/Makefile	Tue Sep 10 22:37:55 2002
> @@ -20,6 +20,14 @@
>  
>  #EXTRA_CFLAGS += -g
>  
> +# Files generated that shall be removed upon make clean
> +clean := aic7xxx_seq.h aic7xxx_reg.h

At lease this line need to be contingent on the actual building of
firmware.  Otherwise you've just blown away the firmware the vendor
has shipped with the system and the user may not have the utilities
to rebuild it.

--
Justin
