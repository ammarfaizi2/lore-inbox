Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbQKUQmi>; Tue, 21 Nov 2000 11:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbQKUQm3>; Tue, 21 Nov 2000 11:42:29 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:23814 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129835AbQKUQmQ>;
	Tue, 21 Nov 2000 11:42:16 -0500
Message-Id: <200011211720.MAA04358@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Rub n Gallardo Fructuoso <ruben@trymedia.com>
cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Address translation 
In-Reply-To: Your message of "Tue, 21 Nov 2000 15:41:26 +0100."
             <DLECJAOCHAKJBLMJFKPIAEPBCCAA.ruben@trymedia.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Nov 2000 12:20:48 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ruben@trymedia.com said:
> Does anybody know a function or method in order to translate an user
> space pointer into a valid pointer in kernel mode?

> 	I'd like to avoid copying data (such as the 'copy_to_user' and
> 'copy_from_user' functions do) because it slows down my system. 

The reason that everyone else uses copy_{to,from}_user is that there is no way 
to guarantee that the userspace pointer is valid.  That memory may have been 
swapped out.  The copy macros are prepared to fault the memory in.  The rest 
of the kernel is not.

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
