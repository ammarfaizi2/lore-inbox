Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVBAPi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVBAPi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVBAPiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:38:19 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:3476 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S262043AbVBAPhh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:37:37 -0500
Message-ID: <009b01c50873$f33bc910$680aa8c0@descartes2>
From: "John T. Williams" <jtwilliams@vt.edu>
To: <vintya@excite.com>, <linux-kernel@vger.kernel.org>
Cc: <linux-c-programming@vger.kernel.org>
References: <20050201135857.154ED1E491@xprdmailfe25.nwk.excite.com>
Subject: Re: Problem in accessing executable files
Date: Tue, 1 Feb 2005 10:37:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a thought.

Text files are better able to handle small faults. ie an extra space or
characters or even an unreadable piece of data might not cause the file to
become unreadable by most text editors.  Binary files aren't as flexible.
Every bit could be an instruction to the processor and might cause a seg
fault.

Just to test the theory, I would start by making the encrypt decrypt
function only effect the first byte.  If doing this doesn't cause a seg
fault, I would recheck my decrypt encrypt algorithm to make sure it doesn't
pad or expand at any point. maybe use them on a regular file and the an
md5sum on the file before and after, just to make extra sure.


----- Original Message ----- 
From: "Vineet Joglekar" <vintya@excite.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-c-programming@vger.kernel.org>
Sent: Tuesday, February 01, 2005 8:58 AM
Subject: Problem in accessing executable files


>
> Hi all,
>
> I am trying to add some cryptographic functionality to ext2 file system
for my masters project. I am working with kernel 2.4.21
>
> since the routines do_generic_file_read and do_generic_file_write are used
in reading and writing, I am decrypting and encrypting the data in the resp.
functions. This is working fine for regular data files. If I try to copy /
execute executable files, I am getting segmentation fault. In kernel
messages, I see same functions (read and write) getting called for the
executables also. If I comment encrypt/decrypt functions, its working fine.
>
> Now since it is working for regular text files, I suppose there is not a
problem in my encrypt/decrypt routines, then what might be going wrong?
>
> Thanks and regards,
>
> Vineet
>
> _______________________________________________
> Join Excite! - http://www.excite.com
> The most personalized portal on the Web!
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-c-programming" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


