Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313459AbSDGULy>; Sun, 7 Apr 2002 16:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313461AbSDGULx>; Sun, 7 Apr 2002 16:11:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34312 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313459AbSDGULw>; Sun, 7 Apr 2002 16:11:52 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: mulix@actcom.co.il (Muli Ben-Yehuda)
Date: Sun, 7 Apr 2002 21:29:01 +0100 (BST)
Cc: movement@marcelothewonderpenguin.com (John Levon),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <20020407225504.Z10733@actcom.co.il> from "Muli Ben-Yehuda" at Apr 07, 2002 10:55:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uJHZ-0006eO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hijacks syscall entries in the sys_call_table as well, because we
> want it to work as a module and not require patching the kernel. Our
> solution to the module unload race on syscall de-hijacking is simple,
> splitting the system call hijacking code into a single small module
> which once loaded cannot be unloaded.

So your small module can export a function called 
	patch_syscall(NR_foo, function);

Now you can put the arch specific syscall patching code into your small
common module and its cleaner anyway ?

Alan
