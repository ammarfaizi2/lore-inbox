Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAWExT>; Mon, 22 Jan 2001 23:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132210AbRAWExA>; Mon, 22 Jan 2001 23:53:00 -0500
Received: from fes-qout.whowhere.com ([209.185.123.96]:62671 "HELO
	mailcity.com") by vger.kernel.org with SMTP id <S129835AbRAWEw4>;
	Mon, 22 Jan 2001 23:52:56 -0500
To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2001 23:52:24 -0500
From: "Gregg Lloyd" <gregg_99@lycos.com>
Message-ID: <PFMKNGGAANDBKAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: gregg_99@mailcity.com
X-Mailer: MailCity Service
Subject: LILO wont boot  my kernel image: More details...
X-Sender-Ip: 209.148.72.107
Organization: Lycos Mail  (http://mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I have a 2.2.5-15 kernel linux system (red Hat 6.0) that is installed on /dev/hdc2. I boot it from a floppy.
Recently, I did compile my new kernel 2.4 on my Linux System.
On the boot floppy, I have LILO (On the hard drive, there's also LILO). 
For booting my new kernel (/boot/vmlinuz-2.4.0), I added following stanza to /etc/lilo.conf (the one on the hard drive): 
image=/boot/vmlinuz-2.4.0
label=linux2.4
root=/dev/hdc2
read-only. 
Lilo was correctly saved (/sbin/lilo..or lilo would display "Added linux2.2 *
Added linux2.4, Added dos). 
But when I rebooted the system
with the boot floppy, LILO wont display linux2.4 so that I can boot with it!
LILO would only show up the old linux. 
I went adding the same stanza (as previously mentionned) to /etc/lilo.conf
that is on the floppy. But the problem is still the same: I do not have the choice to boot with linux2.4!
I tried "lilo -b /dev/fd0" (after /dev/fd0 
have been correctly mounted), but system 
weirdly complained that "open /boot/message: No such file or directory" (which is wrong!).
I got same error message when trying "lilo -C /mnt/floppy/etc/lilo.conf"! 
******Here is my /etc/lilo.conf on hard drive*********
boot=/dev/hdc2
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
image=/boot/vmlinuz-2.2.5-15
label=linux2.2
root=/dev/hdc2
read-only
image=/boot/vmlinuz-2.4.0 
label=linux2.4
root=/dev/hdc2
read-only
other=/dev/hda1 
label=dos 
table=/dev/hda 
*******Here's lilo.conf on boot floppy*****
boot=/dev/fd0
timeout=100
message=/boot/message
prompt
image=/vmlinuz-2.2.5-15
label=linux2.2
root=/dev/hdc2
image=/vmlinuz-2.2.5-15
label=rescue
append="load_ramdisk=2 prompt_ramdisk=1" 
root=/dev/fd0
image=/vmlinuz-2.4.0
label=linux2.4
root=/dev/hdc2
other=/dev/hda1
label=dos
table=/dev/hda


Get your small business started at Lycos Small Business at http://www.lycos.com/business/mail.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
