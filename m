Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267439AbTGHPWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbTGHPWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:22:09 -0400
Received: from lns-th2-5f-81-56-227-145.adsl.proxad.net ([81.56.227.145]:21394
	"EHLO smtp.ced-2.eu.org") by vger.kernel.org with ESMTP
	id S267439AbTGHPVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:21:32 -0400
Message-ID: <3F0AE4DF.80808@ifrance.com>
Date: Tue, 08 Jul 2003 17:35:59 +0200
From: =?ISO-8859-1?Q?C=E9dric_Barboiron?= <ced2ml@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20030624
X-Accept-Language: fr-fr, fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hdX lost interrupt problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm currently having troubles while trying to listen or rip cds audios.
`cdparanoia -Q` works fine
but `strace cdparanoia 1` hangs at :
ioctl(3, 0x530e

Then I have from `dmesg` :
hdc: lost interrupt
hdc: lost interrupt
(...)
hdc: lost interrupt
hdc: lost interrupt

The only thing I found in archives is :
" It seems like the 'lost interrupt' while
ripping audio CDs is specific to VIA based motherboards."

In fact, I have a VIA based motherboard :
VIA KT333 and VIA 8233A

I'm using Linux version 2.4.21 (gcc version 3.2.2) #2 Thu Jul 3 12:42:17 
CEST 2003

Some infos from /proc/ide/ide1/hdc :
driver: ide-cdrom version 4.59-ac1
model: CRD-8322B
settings :
name                    value           min             max             mode
----                    -----           ---             ---             ----
breada_readahead        4               0               127             rw
current_speed           34              0               70              rw
dsc_overlap             0               0               1               rw
file_readahead          0               0               2097151         rw
init_speed              12              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      64              1               127             rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw

I tried setting using_dma 0, unmaskirq 0.
Otherwise, my cdrom works perfectly for data cds.

Please help me

-- 
Cédric Barboiron

