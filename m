Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269002AbRG3QVm>; Mon, 30 Jul 2001 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRG3QVc>; Mon, 30 Jul 2001 12:21:32 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:26897 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S268994AbRG3QVT>; Mon, 30 Jul 2001 12:21:19 -0400
Date: Mon, 30 Jul 2001 18:21:24 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial console and kernel 2.4
Message-ID: <20010730182124.C20366@pc8.lineo.fr>
In-Reply-To: <200107301520.f6UFKtT06867@localhost.localdomain> <20010730173702.C19605@pc8.lineo.fr> <035001c1190f$c6b46700$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <035001c1190f$c6b46700$294b82ce@connecttech.com>; from stuartm@connecttech.com on lun, jui 30, 2001 at 17:53:28 +0200
X-Mailer: Balsa 1.1.7-cvs20010726
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I fully agree with you that the patch is not correct and I'm sure that Reto
agree too.
I'm looking in the code to find the reason but it sounds not easy (termio
stuff ever scare me).
Do you remember a related thread ? with a correct solution ?

Christophe


Le lun, 30 jui 2001 17:53:28, Stuart MacDonald a écrit :
> From: "christophe barbé" <christophe.barbe@lineo.fr>
> > "it works for me" is better that no answer for me. So Thank you for
> your
> > answer.
> > Reto give me a solution : because of a flag all incomming char are
> ignored.
> > So now I need to find why this flag is ok for you and not for me.
> 
> The patch breaks the correct operation of the serial driver.
> CREAD is the flag that enables/disables the rx side of the serial
> port. The kernel or whatever service is trying to use the console
> doesn't set CREAD, so rxed (incoming) characters are ignored.
> 
> You need to find out why the CREAD handling isn't done properly.
> This has come up a number of times on lkml recently; you should
> be able to find an appropriate answer or pointer in the right
> direction by checking the archives.
> 
> Patching the driver breaks the driver instead of fixing the problem.
> 
> ..Stu
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
