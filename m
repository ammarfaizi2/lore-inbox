Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWAPESo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWAPESo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 23:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWAPESo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 23:18:44 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:31248 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751022AbWAPESn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 23:18:43 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Bob Gill <gillb4@telusplanet.net>
Subject: Re: BTTV broken on recent kernels
Date: Mon, 16 Jan 2006 04:18:44 +0000
User-Agent: KMail/1.9
Cc: Linux kernel Mailing list <linux-kernel@vger.kernel.org>
References: <43CAFF82.4030500@telusplanet.net>
In-Reply-To: <43CAFF82.4030500@telusplanet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601160418.44549.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 02:05, Bob Gill wrote:
> Hi.  The last several kernel versions have led to broken bttv (up to 4
> or 5 kernel versions ago, I could watch tv on either mplayer or xawtv),
> but lately bttv is broken.  My card is an 'bt878 compatible built by ATI
> (ATI TV Wonder VE).  I'm pretty certain it worked as late as
> 2.6.14-git7.  I've peeked around /Changes and didn't see anything.   I'm
> using the same build script as before, and a piece of lsmod shows
> serial_core            14848  1 8250
> rtc                     9524  0
> tuner                  36908  0
> bttv                  148564  0
> video_buf              15748  1 bttv
> compat_ioctl32          1152  1 bttv
> i2c_algo_bit            7432  1 bttv
> v4l2_common             6528  2 tuner,bttv
> btcx_risc               3720  1 bttv
> ir_common               7812  1 bttv
> tveeprom               12304  1 bttv
> i2c_core               14864  4 tuner,bttv,i2c_algo_bit,tveeprom
> videodev                6912  1 bttv
> snd_emu10k1            94628  2 snd_emu10k1_synth
> ..........also, a chunk of lspci shows:
> 0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game
> Port (rev 07)
> 0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878
> Video Capture (rev 02)
> 0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio
> Capture (rev 02)
> ....it's just that I get a blank (screen blanking due to no signal)
> screen when I start a tv application.  I can try to change channels/tune
> frequencies, and it looks like the applications are trying, but nothing
> gets tuned in.   To be fair, I must mention that I *ahem* taint the
> kernel with Nvidia stuff, and recently upgraded gcc (although it has
> always worked well with tainted kernel, and it broke before I upgraded
> gcc (to gcc version 4.0.2) on Debian Sarge. 

This problem sounds suspiciously like an overlay bug, known in the binary 
NVIDIA driver. Please try changing it to "nv" in XF86Config, then restarting 
your TV application..

> If you *really* want, I can 
> revert XF86Config to use non-nvidia drivers (and revert back to the old
> version of gcc) and give a bug report from that, but I suspect things
> will remain broken.  Mplayer compiles very well with the new version of
> gcc, and the new kernel (buit with the new version of gcc) does
> everything else (sound, firewire, cd/dvd/networking, disk I/O etc.)
> without problems.
> Thanks in advance,
> Bob

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
