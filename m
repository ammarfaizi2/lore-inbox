Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTIBOS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 10:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTIBOS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 10:18:26 -0400
Received: from mx1.verat.net ([217.26.64.139]:33494 "EHLO mx1.verat.net")
	by vger.kernel.org with ESMTP id S263717AbTIBOR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 10:17:57 -0400
From: snpe <snpe@snpe.co.yu>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4, psmouse doesn't autoload, CONFIG_SERIO doesn't module
Date: Tue, 2 Sep 2003 16:22:05 +0000
User-Agent: KMail/1.5.2
References: <001001c370fa$c47f2e30$6401a8c0@wa1hco>
In-Reply-To: <001001c370fa$c47f2e30$6401a8c0@wa1hco>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309021622.05622.snpe@snpe.co.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I think that a problem is module-init program insmod
insmod don't load any module.I tried for psmouse next :
insmod psmouse
Can't open 'psmouse': No such file or directory
modprobe psmouse
modprobe work
I use module-init-tools 0.9.13 and kernel 2.6.0-test4 (MDK 9.1 and I have to delete -static when compile insmod)
module-init-tools-0.9.14-pre1 don't compile - libsupport.h dosen't exists

regards
Haris PecoOn Tuesday 02 September 2003 02:34 am, jeff millar wrote:
> Some questions
>
> 1. Why doesn't the PS/2 mouse autoload as a module?
> Running 2.6.0-test4, psmouse doesn't autoload as a module.  Oddly, neither
> gpm nor X complains about the missing module, the mouse just doesn't work.
> But if I modprobe psmouse, the cursor starts moving.  I verified that
> /dev/psaux uses char-major-10-1 and that it has an "alias char-major-10-1
> psaux" in modprobe.conf.
>
> 2. Why do I have to compile CONFIG_SERIO into the kernel?  If it's set to
> module, then the link step for various modules complains about missing
> atkbd symbols?
>
> I'd appreciate any hints on what to try.
>
> thanks, jeff
>
> Some more questions to help me understand how this works...
>
> 1. What does kmod send to modprobe?  From looking at modprobe.conf
> apparently "char-major-x-y".
> 2. Does kmod send any other strings to modprobe?
> 3. Documentation/kmod.txt says "passing the name (to modprobe) that was
> requested", couldn't this be more explicit?
> 4. Does kmod gets the major-minor number from the device file upon open(),
> or some other way?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Hello,
I think that a problem is module-init program insmod
insmod don't load any module.I tried for psmouse next :
insmod psmouse
Can't open 'psmouse': No such file or directory
modprobe psmouse
modprobe work
I use module-init-tools 0.9.13 and kernel 2.6.0-test4 (MDK 9.1 and I have to delete -static when compile insmod)
module-init-tools-0.9.14-pre1 don't compile - libsupport.h dosen't exists

regards
Haris PecoOn Tuesday 02 September 2003 02:34 am, jeff millar wrote:
> Some questions
>
> 1. Why doesn't the PS/2 mouse autoload as a module?
> Running 2.6.0-test4, psmouse doesn't autoload as a module.  Oddly, neither
> gpm nor X complains about the missing module, the mouse just doesn't work.
> But if I modprobe psmouse, the cursor starts moving.  I verified that
> /dev/psaux uses char-major-10-1 and that it has an "alias char-major-10-1
> psaux" in modprobe.conf.
>
> 2. Why do I have to compile CONFIG_SERIO into the kernel?  If it's set to
> module, then the link step for various modules complains about missing
> atkbd symbols?
>
> I'd appreciate any hints on what to try.
>
> thanks, jeff
>
> Some more questions to help me understand how this works...
>
> 1. What does kmod send to modprobe?  From looking at modprobe.conf
> apparently "char-major-x-y".
> 2. Does kmod send any other strings to modprobe?
> 3. Documentation/kmod.txt says "passing the name (to modprobe) that was
> requested", couldn't this be more explicit?
> 4. Does kmod gets the major-minor number from the device file upon open(),
> or some other way?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

