Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbRBKXcr>; Sun, 11 Feb 2001 18:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130703AbRBKXcg>; Sun, 11 Feb 2001 18:32:36 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:64038 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130339AbRBKXcU>; Sun, 11 Feb 2001 18:32:20 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank Davis <fdavis112@juno.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-ac10 compile error 
In-Reply-To: Your message of "Sun, 11 Feb 2001 17:34:04 CDT."
             <385378057.981930849661.JavaMail.root@web395-wra.mail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Feb 2001 10:32:12 +1100
Message-ID: <30890.981934332@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001 17:34:04 -0500 (EST), 
Frank Davis <fdavis112@juno.com> wrote:
>Hello,
>    I received the following while compiling 2.4.1-ac10:
>...
>make[3]: *** No rule to make target '/usr/src/linux/drivers/pci/devlist.h', needed by names.o'. Stop
>make[3]: Leaving directory '/usr/src/linux/drivers/pci'
>make[2]: *** [first_rule] Error 2

None of the 2.4.1-ac patches hit drivers/pci/Makefile.  You have
corrupted your source somewhere.  Building from 2.4.1-pristine +
patch-2.4.1-ac10.bz2 gives this in drivers/pci/Makefile.

names.o: names.c devlist.h classlist.h

devlist.h classlist.h: pci.ids gen-devlist
	./gen-devlist <pci.ids

gen-devlist: gen-devlist.c
	$(HOSTCC) $(HOSTCFLAGS) -o gen-devlist gen-devlist.c

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
