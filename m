Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTD1Cfu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 22:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTD1Cfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 22:35:50 -0400
Received: from firenze.terenet.com.br ([200.255.3.10]:42949 "EHLO
	firenze.terenet.com.br") by vger.kernel.org with ESMTP
	id S263369AbTD1Cft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 22:35:49 -0400
From: Rafael Santos <rafael@thinkfreak.com.br>
To: linux-kernel@vger.kernel.org
Date: Mon, 28 Apr 2003 23:47:54 -0300
X-Priority: 3 (Normal)
Reply-To: rafael@thinkfreak.com.br
In-Reply-To: <20030427234215.D16041@almesberger.net>
Message-Id: <0FEZ108QF0E0ZT86OYT835Z64PJ.3eade7da@rafaelnote.ns1.lhost.com.br>
Subject: Re: [RFD] Combined fork-exec syscall.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Opera 6.05 build 1140
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not the point.


4/27/03 11:42:15 PM, Werner Almesberger <wa@almesberger.net> wrote:

>Mark Grosberg wrote:
>>    fmap[0] = in[0];                     /* STDIN  */
>>    fmap[1] = out[1];                    /* STDOUT */
>>    fmap[2] = open("/dev/null", O_RDWR); /* STDERR */
>>    fmap[3] = -1;                        /* end    */
>> 
>>    p = nexec("/bin/cat",
>>              null_argv,
>>              NULL,
>>              filmap);
>
>How about
>
>    fdrplc(3,fmap);
>    exec("/bin/cat",...);
>
>?
>
>0) System call names must be short and cryptic :-)
>1) Requiring the kernel to iterate over the array element by element
>   in order to find out how big it is may be inefficient. Better to
>   pass the length.
>2) System call overhead is marginal, particularly in this case.
>3) There may be other uses than exec(2), where a way for closeing
>   all fds and getting a new set may be useful.
>
>- Werner
>
>-- 
>  _________________________________________________________________________
> / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
>/_http://www.almesberger.net/____________________________________________/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
Rafael Costa dos Santos
ThinkFreak Comércio e Soluções em Hardware e Software
Rio de Janeiro / RJ / Brazil
rafael@thinkfreak.com.br
+ 55 21 9432-9266


