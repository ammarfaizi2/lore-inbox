Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVBLSQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVBLSQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 13:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVBLSQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 13:16:26 -0500
Received: from mail01.hansenet.de ([213.191.73.61]:37828 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S261166AbVBLSQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 13:16:21 -0500
Message-ID: <420E4812.7000006@web.de>
Date: Sat, 12 Feb 2005 19:16:50 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:

 > I wouldn't expect even falling back to pci dma would have this big of an
 > impact on 2d performance, but perhaps there's enough bus activity for
 > this to happen. Marcus, can you verify that you're actually using
 > agpgart in that situation? do you possibly have our XF86Config option
 > set to nvagp only? (with IOMMU compiled in or agpgart loaded, our driver
 > won't allow nvagp) you can verify whether agp is enabled with this
 > command when our driver is loaded and X is started up:

No, IOMMU is now off, too. And I have always used nv_agp with:

Option      "NvAgp" "1"

If the nvidia driver detects the kernel agpgart, it doesn't load nv_agp 
with a big message in the kernel log.

I've just short tested it again:

Doom3 with medium standard settings in 800x600@24bit:

agpgart: 58,1 frames
nv_agp: 63,1 frames

Its a lot in Doom3.

(Simple) 2D test 1280x1024@24bit with x11perf --> http://www.marcush.de/bench/

Same gcc, xorg 6.8.2, 2.6.11-rc3-bk8 kernel, patched (minion.de) 6629 
nvidia drivers to run with newer 2.6.11-rcX kernel,... here was only 
nv_agp and agpgart the difference. In the past without an patched driver 
the same difference.

And again using agpgart with GNOME under X and moving this thunderbird 
mail window or other bigger ones like mozille or firefox over an 
gnome-terminal pulls/draws a ca. 5cm shadow like field slowly after the 
main window. It seems so not fast enough writing to the screen, when 
moving. With nv_agp its really faster and you do not see this.

Bad english... I know. ;)

Greetings,
Marcus
