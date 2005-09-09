Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbVIIBsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbVIIBsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbVIIBsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:48:13 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:54699 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965234AbVIIBsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:48:11 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Date: Fri, 09 Sep 2005 11:47:52 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <m1q1i1lav2vl7k0lpposq0uj4uobsptnor@4ax.com>
References: <20050908053042.6e05882f.akpm@osdl.org>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005 05:30:42 -0700, Andrew Morton <akpm@osdl.org> wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/

Hi Andrew,

After this error:

  CC      drivers/parport/parport_pc.o
drivers/parport/parport_pc.c:2511: error: via_686a_data causes a section type conflict
drivers/parport/parport_pc.c:2520: error: via_8231_data causes a section type conflict
drivers/parport/parport_pc.c:2705: error: parport_pc_superio_info causes a section type conflict
drivers/parport/parport_pc.c:2782: error: cards causes a section type conflict
make[2]: *** [drivers/parport/parport_pc.o] Error 1
make[1]: *** [drivers/parport] Error 2
make: *** [drivers] Error 2

got this:

grant@sempro:/opt/linux/linux-2.6.13-mm2a$ make menuconfig
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/mconf
  HOSTCC  scripts/lxdialog/checklist.o
  HOSTCC  scripts/lxdialog/inputbox.o
  HOSTCC  scripts/lxdialog/lxdialog.o
  HOSTCC  scripts/lxdialog/menubox.o
  HOSTCC  scripts/lxdialog/msgbox.o
  HOSTCC  scripts/lxdialog/textbox.o
  HOSTCC  scripts/lxdialog/util.o
  HOSTCC  scripts/lxdialog/yesno.o
  HOSTLD  scripts/lxdialog/lxdialog
scripts/kconfig/mconf arch/i386/Kconfig
Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP IEEE80211_CRYPT_WEP CRYPTO CRYPTO_ANUBIS
Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP IEEE80211_CRYPT_WEP CRYPTO CRYPTO_MD4
Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP IEEE80211_CRYPT_WEP CRYPTO CRYPTO_MD5
Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP IEEE80211_CRYPT_WEP CRYPTO CRYPTO_AES_X86_64
Warning! Found recursive dependency: NET_RADIO HOSTAP IEEE80211 NET_RADIO HERMES TMD_HERMES
Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP HOSTAP_PCI
Warning! Found recursive dependency: NET_RADIO HOSTAP IEEE80211 NET_RADIO WAVELAN
#
# using defaults found in .config
#
from this: http://bugsplatter.mine.nu/test/boxen/sempro/config-2.6.13-mm2a.gz
and: http://bugsplatter.mine.nu/test/boxen/sempro/config-2.6.13-mm2b.gz
when I tried again, slightly different config.  I don't do wireless networking, 
clueless ;-)

Grant.

