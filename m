Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265764AbUFWCwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUFWCwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 22:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUFWCwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 22:52:33 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15204 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S265764AbUFWCwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 22:52:30 -0400
Date: Tue, 22 Jun 2004 20:49:50 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: returning text from a system call
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <013901c458cc$c14b0b70$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.ln13q27.174i3bp@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm guessing this is an exercise or something - I'm not sure exactly what
you're trying to accomplish with this - but if you created a new system
call, all you'd likely need to do is to have the caller pass in a pointer to
a buffer, as well as the buffer size, with the system call, then just copy
the data into/out of the buffer using copy_to_user and copy_from_user.


----- Original Message ----- 
From: "so usp" <so_usp@yahoo.com.br>
Newsgroups: fa.linux.kernel
To: <linux-kernel@vger.kernel.org>
Sent: Monday, June 21, 2004 2:28 PM
Subject: returning text from a system call


> Hi,
>
> I'm implementing a system call, and I want to return
> information (text data) to the user without using the
> /var/log/messages (using the printk function). I've
> been thinking about writing in a file, but I really
> don't know how to manipulate files in kernel mode. The
> text could be returned to the command line as well,
> but I either don't know how to do that. Does anybody
> could help me how to return text (both ways would be
> good) from a system call?
>
> Thanks, and sorry for the English.
> so_usp
>
> ______________________________________________________________________
>
> Yahoo! Mail - agora com 100MB de espaço, anti-spam e antivírus grá=
> tis!
> http://br.info.mail.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
>  in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

