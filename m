Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288280AbSAMXCt>; Sun, 13 Jan 2002 18:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288277AbSAMXCk>; Sun, 13 Jan 2002 18:02:40 -0500
Received: from nfs1.infosys.tuwien.ac.at ([128.131.172.16]:15327 "EHLO
	infosys.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S288276AbSAMXCY>; Sun, 13 Jan 2002 18:02:24 -0500
Date: Sun, 13 Jan 2002 23:54:54 +0100
From: Thomas Gschwind <tom@infosys.tuwien.ac.at>
To: Doug Ledford <dledford@redhat.com>
Cc: Andris Pavenis <pavenis@latnet.lv>, linux-kernel@vger.kernel.org,
        mozgy@hinet.hr, linux@sigint.cs.purdue.edu
Subject: i810_audio driver v0.20
Message-ID: <20020113235454.A2949@infosys.tuwien.ac.at>
In-Reply-To: <E16Okz2-0005JM-00@the-village.bc.nu> <200201110742.g0B7gDa16387@hal.astr.lu.lv> <3C3EA5D8.7050206@redhat.com> <200201111147.g0BBl5a01992@hal.astr.lu.lv> <3C3F0AA0.8030407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3F0AA0.8030407@redhat.com>; from dledford@redhat.com on Fri, Jan 11, 2002 at 10:54:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug,

On Fri, Jan 11, 2002 at 10:54:08AM -0500, Doug Ledford wrote:
> Actually, as a couple people have pointed out to me, the version on my site 
> was somehow a .19 version.  I've placed the real .20 on my site as of a few 
>   minutes ago, so please try with it (and the real .20 should solve the 
> problem you are related Andris in that it won't allow the driver to accept 
> signals during close, which is why /dev/dsp would quit working for you).

Sorry, haven't had much time the last few days.  I downloaded the
latest version of the i810 driver.  It works perfectly fine on my
K7S5A board exce.  Both playback and recording.

I also looked at the code.  What do think of replacing udelay(1); with
if(offset == 0) udelay(1); in i810_get_dma_addr since the mentioned
picb problem can only occur if picb == 0?

Thomas
-- 
Thomas Gschwind                      Email: tom@infosys.tuwien.ac.at
Technische Universit‰t Wien
Argentinierstraﬂe 8/E1841            Tel: +43 (1) 58801 ext. 18412
A-1040 Wien, Austria, Europe         Fax: +43 (1) 58801 ext. 18491
