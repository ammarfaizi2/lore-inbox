Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSEALnN>; Wed, 1 May 2002 07:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSEALnM>; Wed, 1 May 2002 07:43:12 -0400
Received: from ns.suse.de ([213.95.15.193]:34827 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310835AbSEALnJ>;
	Wed, 1 May 2002 07:43:09 -0400
Date: Wed, 1 May 2002 13:43:05 +0200
From: Dave Jones <davej@suse.de>
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
Cc: linux-kernel@vger.kernel.org, nakasei@fa.mdis.co.jp
Subject: Re: 2.5.12 compile error ( e100, Alternate Intel driver )
Message-ID: <20020501134305.I29327@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Seiichi Nakashima <nakasima@kumin.ne.jp>,
	linux-kernel@vger.kernel.org, nakasei@fa.mdis.co.jp
In-Reply-To: <200205011123.AA00059@prism.kumin.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 08:23:11PM +0900, Seiichi Nakashima wrote:

 > === compile error EtherExpressPro/100 support ( e100, Altrenate Intel driver ) ===
 > 
 > io_apic.c:221: warning: `move' defined but not used
 > drivers/net/net.o: In function `e100_diag_config_loopback':
 > drivers/net/net.o(.text+0x52ff): undefined reference to `e100_phy_reset'
 > make: *** [vmlinux] Error 1

Remove the __devexit tag from e100_phy_reset()'s definition in
drivers/net/e100/e100_phy.c around line 873

I already sent Jeff a patch for this.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
