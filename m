Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUGYK3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUGYK3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 06:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUGYK3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 06:29:44 -0400
Received: from smtpout3.compass.net.nz ([203.97.97.135]:7883 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S263865AbUGYK3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 06:29:40 -0400
Date: Sun, 25 Jul 2004 22:30:13 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@linuxcd
Reply-To: haiquy@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: More compile errors, 2.4.27-rc3 with gcc-3.4.0
Message-ID: <Pine.LNX.4.53.0407252226230.29974@linuxcd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

just in case someone find it usefull I attached the nearly complete
errors and to continue my last post.
kernel 2.4.27-rc3 with the gcc-2.4.0 compile fix patch

gcc-4 -D__KERNEL__ -I/home/linux-2.4.27-rc3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fno-strength-reduce -ffast-math -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -fno-unit-at-a-time -DMODULE -DHISAX_MAX_CARDS=8 -nostdinc -iwithprefix include -DKBUILD_BASENAME=st5481_usb  -c -o st5481_usb.o st5481_usb.c
st5481_usb.c: In function `usb_next_ctrl_msg':
st5481_usb.c:51: error: parse error before "__FUNCTION__"
st5481_usb.c: In function `usb_ctrl_msg':
st5481_usb.c:67: error: parse error before "__FUNCTION__"
st5481_usb.c: In function `usb_ctrl_complete':
st5481_usb.c:134: error: parse error before "__FUNCTION__"
st5481_usb.c: In function `usb_int_complete':
st5481_usb.c:188: error: parse error before "__FUNCTION__"
st5481_usb.c: In function `st5481_setup_usb':
st5481_usb.c:244: error: parse error before "__FUNCTION__"
st5481_usb.c:253: error: parse error before "__FUNCTION__"
st5481_usb.c:263: error: parse error before "__FUNCTION__"
st5481_usb.c: In function `st5481_start':
st5481_usb.c:360: error: parse error before "__FUNCTION__"
st5481_usb.c: In function `usb_in_complete':
st5481_usb.c:474: error: parse error before "__FUNCTION__"
st5481_usb.c:504: error: parse error before "__FUNCTION__"
st5481_usb.c:510: error: parse error before "__FUNCTION__"
st5481_usb.c:512: error: parse error before "__FUNCTION__"
st5481_usb.c:514: error: parse error before "__FUNCTION__"
st5481_usb.c:522: error: parse error before "__FUNCTION__"
st5481_usb.c: In function `st5481_start_rcv':
st5481_usb.c:609: error: parse error before "__FUNCTION__"
st5481_usb.c:612: error: parse error before "__FUNCTION__"
make[3]: *** [st5481_usb.o] Error 1
make[3]: Leaving directory `/home/linux-2.4.27-rc3/drivers/isdn/hisax'
make[2]: *** [_modsubdir_hisax] Error 2
make[2]: Leaving directory `/home/linux-2.4.27-rc3/drivers/isdn'
make[1]: *** [_modsubdir_isdn] Error 2
make[1]: Leaving directory `/home/linux-2.4.27-rc3/drivers'
make: *** [_mod_drivers] Error 2


gcc-4 -D__KERNEL__ -I/home/linux-2.4.27-rc3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fno-strength-reduce -ffast-math -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -fno-unit-at-a-time -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ns83820  -c -o ns83820.o ns83820.c
ns83820.c:591: error: conflicting types for 'rx_refill_atomic'
ns83820.c:589: error: previous declaration of 'rx_refill_atomic' was here
ns83820.c:591: error: conflicting types for 'rx_refill_atomic'
ns83820.c:589: error: previous declaration of 'rx_refill_atomic' was here
ns83820.c:612: error: conflicting types for 'phy_intr'
ns83820.c:610: error: previous declaration of 'phy_intr' was here
ns83820.c:612: error: conflicting types for 'phy_intr'
ns83820.c:610: error: previous declaration of 'phy_intr' was here
ns83820.c:797: error: conflicting types for 'ns83820_rx_kick'
ns83820.c:795: error: previous declaration of 'ns83820_rx_kick' was here
ns83820.c:797: error: conflicting types for 'ns83820_rx_kick'
ns83820.c:795: error: previous declaration of 'ns83820_rx_kick' was here
ns83820.c:818: error: conflicting types for 'rx_irq'
ns83820.c:816: error: previous declaration of 'rx_irq' was here
ns83820.c:818: error: conflicting types for 'rx_irq'
ns83820.c:816: error: previous declaration of 'rx_irq' was here
ns83820.c:589: warning: 'rx_refill_atomic' declared `static' but never defined
ns83820.c:610: warning: 'phy_intr' declared `static' but never defined
ns83820.c:795: warning: 'ns83820_rx_kick' declared `static' but never defined
ns83820.c:816: warning: 'rx_irq' declared `static' but never defined
ns83820.c:1708: warning: 'ns83820_probe_phy' defined but not used
make[2]: *** [ns83820.o] Error 1
make[2]: Leaving directory `/home/linux-2.4.27-rc3/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/home/linux-2.4.27-rc3/drivers'
make: *** [_mod_drivers] Error 2


gcc-4 -D__KERNEL__ -I/home/linux-2.4.27-rc3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fno-strength-reduce -ffast-math -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -fno-unit-at-a-time -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=core  -c -o core.o core.c
core.c:410: error: conflicting types for '__rfcomm_dlc_throttle'
/home/linux-2.4.27-rc3/include/net/bluetooth/rfcomm.h:265: error: previous declaration of '__rfcomm_dlc_throttle' was here
core.c:410: error: conflicting types for '__rfcomm_dlc_throttle'
/home/linux-2.4.27-rc3/include/net/bluetooth/rfcomm.h:265: error: previous declaration of '__rfcomm_dlc_throttle' was here
core.c:421: error: conflicting types for '__rfcomm_dlc_unthrottle'
/home/linux-2.4.27-rc3/include/net/bluetooth/rfcomm.h:266: error: previous declaration of '__rfcomm_dlc_unthrottle' was here
core.c:421: error: conflicting types for '__rfcomm_dlc_unthrottle'
/home/linux-2.4.27-rc3/include/net/bluetooth/rfcomm.h:266: error: previous declaration of '__rfcomm_dlc_unthrottle' was here
make[3]: *** [core.o] Error 1
make[3]: Leaving directory `/home/linux-2.4.27-rc3/net/bluetooth/rfcomm'
make[2]: *** [_modsubdir_rfcomm] Error 2
make[2]: Leaving directory `/home/linux-2.4.27-rc3/net/bluetooth'
make[1]: *** [_modsubdir_bluetooth] Error 2
make[1]: Leaving directory `/home/linux-2.4.27-rc3/net'
make: *** [_mod_net] Error 2

// As this bluetooth module is essential then I disabled all blue tooth support to continue so not sure if any other file in bluetooth has compiling problem or not.

Best regards,

Steve Kieu
