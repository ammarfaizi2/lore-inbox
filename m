Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312494AbSDNXUV>; Sun, 14 Apr 2002 19:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312497AbSDNXUV>; Sun, 14 Apr 2002 19:20:21 -0400
Received: from conx.aracnet.com ([216.99.200.135]:50933 "HELO cj90.in.cjcj.com")
	by vger.kernel.org with SMTP id <S312494AbSDNXUU>;
	Sun, 14 Apr 2002 19:20:20 -0400
Message-ID: <3CBA0EAD.205@cjcj.com>
Date: Sun, 14 Apr 2002 16:20:13 -0700
From: CJ <cj@cjcj.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: IDE performance 2.4.18 slower than MSDOS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are for an unmounted Seagate 80GB IDE Primary
ST380021A DMA in a Celeron 466, Intel 815BN, 256MB.

dd 4.0.36  linux-2.4.18--------
MB/s       Input  Output Hdparm
DOS        42.10      ?  -Tt
/dev/hda   36.36  19.94   37.21
/dev/raw    2.86   3.28   98.46

Linux 2.4.18

time dd if=/dev/hda of=/dev/nul
301.6user 1093system 36:41.05elapsed 63%cpu
36.36MB/s

time dd if=/dev/raw/raw80 of=/dev/nul
690.95user 5060.35system 7:31:39elapsed 21%cpu
(IDE light dim)
2.86MB/s

time dd if=/dev/zero of=/dev/raw/raw80
626.32user 7570.34system 6:46:39elapsed 33%cpu
(IDE light dim)
3.28MB/s

time dd if=/dev/zero of=/dev/hda
304.34user  1413system  1:06:54elapsed 42%cpu
(IDE light medium 123456, IDE light off 789)repeats throughtout
19.94MB/s



