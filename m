Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271414AbTHHPpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271415AbTHHPpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:45:35 -0400
Received: from mail.bbb2.mdc-berlin.de ([141.80.34.25]:4877 "EHLO
	mail.bbb2.mdc-berlin.de") by vger.kernel.org with ESMTP
	id S271414AbTHHPpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:45:30 -0400
Subject: 2.6.0-test2 does not boot with matroxfb
From: Juergen Rose <rose@rz.uni-potsdam.de>
To: linux-kernel@vger.kernel.org
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Content-Type: multipart/mixed; boundary="=-orS6YCFmBEQgfbr3zNYc"
Organization: Max-Delbrueck-Zentrum
Message-Id: <1060357528.19833.11.camel@moen.bioinf.mdc-berlin.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Aug 2003 17:45:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-orS6YCFmBEQgfbr3zNYc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I tried on my PC with a Matrox-G450 several kernel and boot options.
Every time when the console should work with matrox framebuffer, linux
was crashed. With 2.6.0-test2 and 2.6.0-test2-bk7 I had the following
warning performing ''make modules_install''
WARNING:
/lib/modules/2.6.0-test2[-bk7]/kernel/drivers/video/matrox/matroxfb_crtc2.ko needs unknown symbol matroxfb_enable_irq
This WARNING disapears for 2.6.0-test2-mm5. But also 2.6.0-test2-mm5
does not work with framebuffer. I tested the following combinations of
parameters:

                            |VGA = 6  |  VGA = 775    |
                            |         |               |video=matrox:
                            |         |               |   vesa:0x31C 
----------------------------+---------+---------------+---------------
2.4.22-pre6-ac1             |         |               |
CONFIG_FB=y                 | VGA=6   |  VGA=775      | vesa:0x31C
CONFIG_VIDEO_SELECT=y       |         |               |
----------------------------+---------+---------------+---------------
2.6.0-test2                 |         |crashes        |crashes        
CONFIG_FRAMEBUFFER_CONSOLE=y|  VGA=6  |after          |after          
CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
----------------------------+---------+---------------+---------------
2.6.0-test2                 |         |               | 
CONFIG_FRAMEBUFFER_CONSOLE=y| 640x480 |  640x480      |  640x480
CONFIG_VIDEO_SELECT=n       |         |               |  
----------------------------+---------+---------------+---------------
2.6.0-test2                 |         |crashes        |crashes
without console-fb          |  VGA=6  |after          |after
CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
----------------------------+---------+---------------+---------------
2.6.0-test2                 |         |               |
without console-fb          | 640x480 |  640x480      |  640x480
CONFIG_VIDEO_SELECT=n       |         |               |
----------------------------+---------+---------------+---------------
2.6.0-test2-bk7             |         |crashes        |crashes
with console-fb             | VGA=6   |after          |after
CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
----------------------------+---------+---------------+---------------
2.6.0-test2-mm5             |         |crashes        |crashes
CONFIG_FRAMEBUFFER_CONSOLE=y| VGA=6   |after          |after
CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
----------------------------+---------+---------------+---------------

Because I am afraid, that the lines of the table are wrapped by the mail
client, the is alsa attached to this mail. Any hint would very much
appreciated.

	Regards
		Juergen

-- 
Juergen Rose <rose@rz.uni-potsdam.de>
Max-Delbrueck-Zentrum

--=-orS6YCFmBEQgfbr3zNYc
Content-Disposition: attachment; filename=2.6.0-test2_problems_table.txt
Content-Type: text/plain; name=2.6.0-test2_problems_table.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Results of some kernel and boot parameters:

                            |VGA = 6  |  VGA = 775    |
                            |         |               |video=matrox:
                            |         |               |   vesa:0x31C 
----------------------------+---------+---------------+---------------
2.4.22-pre6-ac1             |         |               |
CONFIG_FB=y                 | VGA=6   |  VGA=775      | vesa:0x31C
CONFIG_VIDEO_SELECT=y       |         |               |
----------------------------+---------+---------------+---------------
2.6.0-test2                 |         |crashes        |crashes        
CONFIG_FRAMEBUFFER_CONSOLE=y|  VGA=6  |after          |after          
CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
----------------------------+---------+---------------+---------------
2.6.0-test2                 |         |               | 
CONFIG_FRAMEBUFFER_CONSOLE=y| 640x480 |  640x480      |  640x480
CONFIG_VIDEO_SELECT=n       |         |               |  
----------------------------+---------+---------------+---------------
2.6.0-test2                 |         |crashes        |crashes
without console-fb          |  VGA=6  |after          |after
CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
----------------------------+---------+---------------+---------------
2.6.0-test2                 |         |               |
without console-fb          | 640x480 |  640x480      |  640x480
CONFIG_VIDEO_SELECT=n       |         |               |
----------------------------+---------+---------------+---------------
2.6.0-test2-bk7             |         |crashes        |crashes
with console-fb             | VGA=6   |after          |after
CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
----------------------------+---------+---------------+---------------
2.6.0-test2-mm5             |         |crashes        |crashes
CONFIG_FRAMEBUFFER_CONSOLE=y| VGA=6   |after          |after
CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
----------------------------+---------+---------------+---------------


--=-orS6YCFmBEQgfbr3zNYc--

