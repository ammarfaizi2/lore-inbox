Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUA0EM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 23:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUA0EM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 23:12:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:50541 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261890AbUA0EMx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 23:12:53 -0500
To: <linux-kernel@vger.kernel.org>
Subject: radeonfb problems with 2.6.2-rc2
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 26 Jan 2004 20:12:51 -0800
In-Reply-To: <Pine.LNX.4.44.0311111019210.30657-100000@home.osdl.org>
Message-ID: <52y8rughbw.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 27 Jan 2004 04:12:52.0985 (UTC) FILETIME=[D57D4690:01C3E48B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just decided to give radeonfb a try with a 2.6 kernel (2.6.2-rc2 to
be specific).  I have a Radeon 9000 Pro with two 1280x1024 LCDs
connected, one to the DVI connector and one to the CRT connector.
When it boots, I get a glimpse of the penguin logo for a moment, and
then the screen goes blank and stays blank.  If I start the Radeon
XFree86 server then both screens come back to life and work fine.

I get the following in my boot log:

    Linux version 2.6.2-rc2 (root@gold) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Mon Jan 26 11:41:46 PST 2004

    [...]

    radeonfb_pci_register BEGIN
    radeonfb: ref_clk=2700, ref_div=12, xclk=27500 from BIOS
    radeonfb: probed DDR SGRAM 65536k videoram
    radeon_get_moninfo: bios 4 scratch = a00000a
    radeonfb: panel ID string: ªhé£
    radeonfb: detected DFP panel size from BIOS: 1x0
    radeonfb: detected DFP panel size from registers: 1280x1024
    radeonfb: ATI Radeon 9000 If DDR SGRAM 64 MB
    radeonfb: DVI port DFP monitor connected
    radeonfb: CRT port CRT monitor connected
    radeonfb_pci_register END

    [...]

    hStart = 680, hEnd = 960, hTotal = 1056
    vStart = 482, vEnd = 501, vTotal = 522
    h_total_disp = 0x4f0083	   hsync_strt_wid = 0xa302a2
    v_total_disp = 0x1df0209	   vsync_strt_wid = 0x9301e1
    post div = 0x8
    fb_div = 0x59
    ppll_div_3 = 0x30059
    ron = 828, roff = 19684
    vclk_freq = 2503, per = 703
    Console: switching to colour frame buffer device 80x30

I've seen some radeonfb patches floating around, but my impression was
that 2.6.2-rc2 should work.  If anyone has something for me to try,
I'd be happy to give it a spin.  Otherwise I guess I'll try to figure
out what that debugging output is telling me.

Thanks,
  Roland
