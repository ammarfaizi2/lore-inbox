Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUEFQq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUEFQq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUEFQq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:46:58 -0400
Received: from dcs-server2.cs.uiuc.edu ([128.174.252.3]:32180 "EHLO
	dcs-server2.cs.uiuc.edu") by vger.kernel.org with ESMTP
	id S261234AbUEFQqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:46:48 -0400
From: "Zhenmin Li" <zli4@cs.uiuc.edu>
To: "'Geert Uytterhoeven'" <geert@linux-m68k.org>,
       "'Linux/m68k'" <linux-m68k@lists.linux-m68k.org>,
       "'Linux/m68k on Mac'" <linux-mac68k@mac.linux-m68k.org>
Cc: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: RE: [OPERA] Potential bugs detected by static analysis tool in 2.6.4
Date: Thu, 6 May 2004 11:44:37 -0500
Message-ID: <002d01c43389$6bbbea70$76f6ae80@Turandot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <Pine.GSO.4.58.0405061141290.12096@waterleaf.sonytel.be>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the typo. The line number should be 264, and the context is:

if (macintosh_config->adb_type == MAC_ADB_IOP) {
	if (macintosh_config->ident == MAC_MODEL_IIFX) {
		iop_base[IOP_NUM_ISM] = (struct mac_iop *)
ISM_IOP_BASE_IIFX;
	} else {
		iop_base[IOP_NUM_ISM] = (struct mac_iop *)
ISM_IOP_BASE_QUADRA;
	}
	iop_base[IOP_NUM_SCC]->status_ctrl = 0;
	iop_ism_present = 1;
}

Thanks,
OPERA Research Group

 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Geert Uytterhoeven
Sent: Thursday, May 06, 2004 4:44 AM
To: Linux/m68k; Linux/m68k on Mac
Cc: Zhenmin Li; Linux Kernel Development
Subject: Re: [OPERA] Potential bugs detected by static analysis tool in
2.6.4

On Wed, 5 May 2004, Zhenmin Li wrote:
> We ran our static analysis tool upon Linux 2.6.4 source files, and found
> some potential errors. Since all of them are detected by the tool, we need
> more effort to inspect. We would appreciate your help if anyone can verify
> whether they are bugs or not.
>
> Thanks a lot,
>
> OPERA Research Group
> University of Illinois at Urbana-Champaign
>
>
>
> Version: 2.6.4

    [...]

> 8. /arch/m68k/mac/iop.c, Line 164:

Should be line 264?

> iop_base[IOP_NUM_SCC]->status_ctrl = 0;
>
> Maybe change to:
> iop_base[IOP_NUM_ISM]->status_ctrl = 0;

Mac guys, is this correct?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
							    -- Linus
Torvalds
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

