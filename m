Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132389AbRDCRrA>; Tue, 3 Apr 2001 13:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRDCRqt>; Tue, 3 Apr 2001 13:46:49 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:44806 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132389AbRDCRqd>; Tue, 3 Apr 2001 13:46:33 -0400
Message-ID: <3ACA0C40.3F25E5A5@vc.cvut.cz>
Date: Tue, 03 Apr 2001 10:45:36 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: Elmer Joandi <elmer@linking.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 SMP: nfs stale handle, fb dualhead hardlock, G400/450 
 misnaming
In-Reply-To: <Pine.LNX.4.21.0104031152270.21867-100000@ns.linking.ee>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elmer Joandi wrote:

> 2. Hard lockup:
>         G450, I set con2fb, switch consoles some times and there it comes.
>         swithc between X and single console is OK.

Did you boot with 'video=scrollback:0' ? You must ;-)
 
> 3. seems that I have G450 and linux shows it as G400.
>         bash-2.04$ /sbin/lspci:
>         01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)
>         /proc/pci:
>          VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 130).

rev < 128 => G400, rev >= 128 => G450. Ask Matrox why they did so stupid
thing.
 
>         G400 drivers also work, but matroxset aint switching second head
>         to monitor output, neither does anything else. It remains blank.

Secondary output on G400 is in monitor mode by default. Are you sure
that you
insmodded all needed modules to kernel? i2c-matrox, matroxfb_maven,
matroxfb_crtc2, ...
If you do not know which ones, just build everything into kernel - and
do not forget
about i2c bit-banging as documented in documentation...
								Petr Vandrovec
								vandrove@vc.cvut.cz
