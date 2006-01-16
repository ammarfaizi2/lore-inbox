Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWAPB6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWAPB6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 20:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWAPB6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 20:58:43 -0500
Received: from outbound04.telus.net ([199.185.220.223]:8144 "EHLO
	priv-edtnes27.telusplanet.net") by vger.kernel.org with ESMTP
	id S932159AbWAPB6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 20:58:43 -0500
Message-ID: <43CAFF82.4030500@telusplanet.net>
Date: Sun, 15 Jan 2006 19:05:54 -0700
From: Bob Gill <gillb4@telusplanet.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: BTTV broken on recent kernels
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  The last several kernel versions have led to broken bttv (up to 4 
or 5 kernel versions ago, I could watch tv on either mplayer or xawtv), 
but lately bttv is broken.  My card is an 'bt878 compatible built by ATI 
(ATI TV Wonder VE).  I'm pretty certain it worked as late as 
2.6.14-git7.  I've peeked around /Changes and didn't see anything.   I'm 
using the same build script as before, and a piece of lsmod shows
serial_core            14848  1 8250
rtc                     9524  0
tuner                  36908  0
bttv                  148564  0
video_buf              15748  1 bttv
compat_ioctl32          1152  1 bttv
i2c_algo_bit            7432  1 bttv
v4l2_common             6528  2 tuner,bttv
btcx_risc               3720  1 bttv
ir_common               7812  1 bttv
tveeprom               12304  1 bttv
i2c_core               14864  4 tuner,bttv,i2c_algo_bit,tveeprom
videodev                6912  1 bttv
snd_emu10k1            94628  2 snd_emu10k1_synth
..........also, a chunk of lspci shows:
0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game 
Port (rev 07)
0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 
Video Capture (rev 02)
0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
Capture (rev 02)
....it's just that I get a blank (screen blanking due to no signal) 
screen when I start a tv application.  I can try to change channels/tune 
frequencies, and it looks like the applications are trying, but nothing 
gets tuned in.   To be fair, I must mention that I *ahem* taint the 
kernel with Nvidia stuff, and recently upgraded gcc (although it has 
always worked well with tainted kernel, and it broke before I upgraded 
gcc (to gcc version 4.0.2) on Debian Sarge.  If you *really* want, I can 
revert XF86Config to use non-nvidia drivers (and revert back to the old 
version of gcc) and give a bug report from that, but I suspect things 
will remain broken.  Mplayer compiles very well with the new version of 
gcc, and the new kernel (buit with the new version of gcc) does 
everything else (sound, firewire, cd/dvd/networking, disk I/O etc.) 
without problems.
Thanks in advance,
Bob
