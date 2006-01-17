Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWAQSWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWAQSWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWAQSWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:22:38 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:1986 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbWAQSWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:22:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CbXBYf1K3B2+OrnEncoQ7fmD7CE8N4Ki4OF3sMM4xRQ62Tq3F2Qrkn6CUvoRL9lU0wWtBBkSpTre8M/QXTwce++lpbCUmhhZ82SldabItAU4/XS2RqTKwqdyD+0votENcSipHH83HNvQEmIjJV/7LKActtzv5ekoz0SKiQY/1lY=
Message-ID: <d9def9db0601171022q5349a759x2aeddbfff117662a@mail.gmail.com>
Date: Tue, 17 Jan 2006 19:22:35 +0100
From: Markus Rechberger <mrechberger@gmail.com>
To: homchenko@ixx.ru, Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: [PATCH 25/25] Added remote control support for pinnacle pctv
Cc: Video4linux-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <dqj7nl$8db$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116091105.PS83611600000@infradead.org>
	 <20060116091126.PS06106100025@infradead.org>
	 <dqj7nl$8db$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

what kernel version do you use?
cat /proc/version

could you try to load the module with i2c_debug=2 and press several buttons.
Finally send me the logfile (no need to send it to the list).

Markus


On 1/17/06, victorhom <homchenko@ixx.ru> wrote:
> mchehab@infradead.org wrote
> >
> > From: Markus Rechberger <mrechberger@gmail.com>
> >
> Hi, Markus!
>
> Remote control is not working, sorry :(
>
> # cat /etc/modprobe.d/tv
> options em28xx tuner=63 ir_debug=1 i2c_scan=1 i2c_debug=1
> options tuner secam=d pal=d
>
> # modprobe em28xx
> # modprobe ir-kbd-i2c
> # dmesg
>
> tveeprom: module not supported by Novell, setting U taint flag.
> ir_common: module not supported by Novell, setting U taint flag.
> em28xx: module not supported by Novell, setting U taint flag.
> em28xx v4l2 driver version 0.0.1 loaded
> em28xx new video device (2304:0208): interface 0, class 255
> em28xx: Alternate settings: 8
> em28xx: Alternate setting 0, max size= 0
> em28xx: Alternate setting 1, max size= 1024
> em28xx: Alternate setting 2, max size= 1448
> em28xx: Alternate setting 3, max size= 2048
> em28xx: Alternate setting 4, max size= 2304
> em28xx: Alternate setting 5, max size= 2580
> em28xx: Alternate setting 6, max size= 2892
> em28xx: Alternate setting 7, max size= 3072
> saa711x: module not supported by Novell, setting U taint flag.
> saa711x: Ignoring new-style parameters in presence of obsolete ones
> tuner: module not supported by Novell, setting U taint flag.
> tda9887: module not supported by Novell, setting U taint flag.
> attach_inform: saa7113 detected.
> tuner 0-0063: chip found @ 0xc6 (em28xx #0)
> attach inform: detected I2C address c6
> tuner 0-0063: type set to 63 (Philips FMD1216ME MK3 Hybrid Tuner)
> tda9887 0-0043: chip found @ 0x86 (em28xx #0)
> em28xx #0: i2c eeprom 00: 1a eb 67 95 04 23 08 02 10 00 1e 03 98 2a 6a 2e
> em28xx #0: i2c eeprom 10: 00 00 06 57 6e 00 00 00 8e 00 00 00 07 00 00 00
> em28xx #0: i2c eeprom 20: 16 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> em28xx #0: i2c eeprom 30: 00 00 20 40 20 80 02 20 10 01 00 00 00 00 00 00
> em28xx #0: i2c eeprom 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> em28xx #0: i2c eeprom 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> em28xx #0: i2c eeprom 60: 00 00 00 00 00 00 00 00 00 00 2e 03 50 00 69 00
> em28xx #0: i2c eeprom 70: 6e 00 6e 00 61 00 63 00 6c 00 65 00 20 00 53 00
> em28xx #0: i2c eeprom 80: 79 00 73 00 74 00 65 00 6d 00 73 00 20 00 47 00
> em28xx #0: i2c eeprom 90: 6d 00 62 00 48 00 00 00 2a 03 50 00 43 00 54 00
> em28xx #0: i2c eeprom a0: 56 00 20 00 55 00 53 00 42 00 32 00 20 00 50 00
> em28xx #0: i2c eeprom b0: 41 00 4c 00 2f 00 53 00 45 00 43 00 41 00 4d 00
> em28xx #0: i2c eeprom c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> em28xx #0: i2c eeprom d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> em28xx #0: i2c eeprom e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> em28xx #0: i2c eeprom f0: 00 00 00 00 00 00 00 00 0c 22 17 38 02 90 2b 3e
> EEPROM ID= 0x9567eb1a
> Vendor/Product ID= 2304:0208
> AC97 audio (5 sample rates)
> 500mA max power
> Table at 0x06, strings=0x2a98, 0x2e6a, 0x0000
> em28xx #0: found i2c device @ 0x4a [saa7113h]
> em28xx #0: found i2c device @ 0x86 [tda9887]
> em28xx #0: found i2c device @ 0x8e [remote IR sensor]
> em28xx #0: found i2c device @ 0xa0 [eeprom]
> em28xx #0: found i2c device @ 0xc6 [tuner (analog)]
> em28xx #0: V4L2 device registered as /dev/video0
> em28xx #0: Found Pinnacle PCTV USB 2
> usbcore: registered new driver em28xx
> ir_kbd_i2c: module not supported by Novell, setting U taint flag.
> attach_inform: IR detected ().
> ir-kbd-i2c: i2c IR (EM28XX Pinnacle PCTV) detected at i2c-0/0-0047/ir0
> [em28xx #0]
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 00
> i2c IR (EM28XX Pinnacle PCTV): unknown key: key=0x00 raw=0x00 down=1
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV): unknown key: key=0x00 raw=0x00 down=0
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> ...
> ...
>
> >From /var/log/messages:
>
> Jan 17 23:51:30 6-199 kernel: i2c IR (EM28XX Pinnacle PCTV)/ir: key 3f
> Jan 17 23:52:01 6-199 last message repeated 301 times
> Jan 17 23:53:02 6-199 last message repeated 610 times
> Jan 17 23:54:03 6-199 last message repeated 609 times
> Jan 17 23:55:04 6-199 last message repeated 610 times
> ...
>
> These 'key 3f' are received without touching any bytton on the remote.
> Pressing any key some times sometimes ( sorry my english :) turn a key UP
> (3f from your table).
>
> That's all.
>
> --
> Victor Homchenko
>
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
>


--
Markus Rechberger
