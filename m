Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272509AbTHEQMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270169AbTHEQMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:12:42 -0400
Received: from pl054.nas911.n-yokohama.nttpc.ne.jp ([210.139.98.54]:3524 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id S270148AbTHEQMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:12:36 -0400
Message-ID: <3F2FD6ED.1005BB2C@yk.rim.or.jp>
Date: Wed, 06 Aug 2003 01:10:21 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: wb <dead_email@nospam.com>
CC: Paul Blazejowski <paulb@blazebox.homeip.net>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
References: <20030801182207.GA3759@blazebox.homeip.net>	    <20030801144455.450d8e52.akpm@osdl.org>	    <20030803015510.GB4696@blazebox.homeip.net>	    <20030802190737.3c41d4d8.akpm@osdl.org>	    <20030803214755.GA1010@blazebox.homeip.net>	    <20030803145211.29eb5e7c.akpm@osdl.org>	    <20030803222313.GA1090@blazebox.homeip.net>	    <20030803223115.GA1132@blazebox.homeip.net>	    <20030804093035.A24860@beaverton.ibm.com>    <1060021614.889.6.camel@blaze.homeip.net>    <1352160000.1060025773@aslan.btc.adaptec.com> <5793.199.181.174.146.1060050091.squirrel@www.blazebox.homeip.net> <3F2F84D2.8000202@nospam.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry this is not strictly related to SCSI, but I could not help it.)

Regarding the use of a program from uucp suite
for console output capture,
we can use C-Kermit as well.

>   Your need a NULL modem serial cable available
>   from any computer store.
> 
> Install uucp - I use on the HOST :
> 
> uucp-1.06.1-33.7.2.

Or you can use C-Kermit.
See

   http://www.columbia.edu/kermit/ckermit.html

for details. There are precompiled packages.

>  ... [omission ] ...

> 5. Start uucp on the HOST:
> 
>      cu -l /dev/ttyS0 -s 9600

       kermit
       set line /dev/ttyS0
       set speed 9600
       connect
 
and you can issue other commands.
        set [space] ?
will print all the available options at that point.
(You can log the interaction into a file by issueing
a command to kermit, too, but using script and then run kermit
inside the scripted session might be easier.)
(Generally speaking hitting ? somewhere on the kermit command line
prints usable options/setting/keywords, and so
you can learn the basics very quickly.)
You can set up a startup file that sets
the device name, speed, parity, data size, etc. and
so you don't have to type all the command every time.

While I agree cu might work well for one shot job,
running a full terminal emulator like C-Kermit
helps us in the long term.

Just thought to let you know a full-featured terminal
emulator is available under linux.

> John Donnelly AT HP DOT com

Is the succinct and to the point steps
part of a widely available document?

I wish I knew this a few years ago.


-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
