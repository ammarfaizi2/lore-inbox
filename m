Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264395AbRFLN3q>; Tue, 12 Jun 2001 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264416AbRFLN3g>; Tue, 12 Jun 2001 09:29:36 -0400
Received: from mx6.port.ru ([194.67.23.42]:61458 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S264395AbRFLN3X>;
	Tue, 12 Jun 2001 09:29:23 -0400
Date: Tue, 12 Jun 2001 18:19:49 +0400
From: Sergey Tursanov <__gsr@mail.ru>
X-Mailer: The Bat! (v1.49)
Reply-To: Sergey Tursanov <__gsr@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <19562259.20010612181949@mail.ru>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PC keyboard rate/delay
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------B912C1FC2DD4EE15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------B912C1FC2DD4EE15
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In file include/linux/kd.h was declared KDKBDREP ioctl number
to tune up keyboard rate/delay with struct kbd_repeat.
But in 2.4.x kernel there is only m68k version for that.
I wrote some code for implement this feature on x86 machines.
Gzipped and uuencoded patch for kernel 2.4.5 is attached.
To setup keyboard rate/delay on x86 you should use code like that:

struct kbd_repeat kbd_rep={
       1000,      /* delay in ms */
       30         /* repeat rate in cps */
};
ioctl(0,KDKBDREP,&kbd_rep);

After that ioctl kbd_rep is filled with previous values.

I hope it will be useful for someone.
------------B912C1FC2DD4EE15
Content-Type: application/x-gzip; name="patch-kbdrate-2.4.5.gz"
Content-Transfer-Encoding: x-uue
Content-Disposition: attachment; filename="patch-kbdrate-2.4.5.gz"

begin 644 patch-kbdrate-2.4.5.gz
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
-"//5\3_V!/'UKQ(`````
`
end

------------B912C1FC2DD4EE15--


