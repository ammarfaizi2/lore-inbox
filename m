Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265756AbRF2IQu>; Fri, 29 Jun 2001 04:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265757AbRF2IQk>; Fri, 29 Jun 2001 04:16:40 -0400
Received: from adsl-63-198-73-118.dsl.lsan03.pacbell.net ([63.198.73.118]:16134
	"HELO turing.xman.org") by vger.kernel.org with SMTP
	id <S265756AbRF2IQd>; Fri, 29 Jun 2001 04:16:33 -0400
Message-Id: <5.1.0.14.0.20010629011426.029e0558@imap.xman.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 29 Jun 2001 01:16:33 -0700
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>,
        John Fremlin <vii@users.sourceforge.net>, Dan Kegel <dank@kegel.com>
From: Christopher Smith <x@xman.org>
Subject: RE: A signal fairy tale - a little comphist
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <27525795B28BD311B28D00500481B7601F151A@ftrs1.intranet.ftr.
 nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:57 PM 6/28/2001 +0200, Heusden, Folkert van wrote:
>[...]
> >        A signal number cannot be opened more than once concurrently;
> >        sigopen() thus provides a way to avoid signal usage clashes
> >        in large programs.
>YOU> Signals are a pretty dopey API anyway -
>
>Exactly. When signals were made up, signalhandlers were supposed to
>not so much more then a last cry and then exit the application. sigHUP
>to re-read the config was not supposed to happen.
>
>YOU> so instead of trying to patch
>YOU> them up, why not think of something better for AIO?
>
>Yeah, a select() on excepfds.

POSIX AIO API's are significantly more powerful then using select(), 
particularly for certain types of applications. select() doesn't provide 
you with a good way to perform I/O operations at different offsets 
simultaneously, doesn't allow for I/O priority, etc.

--Chris

