Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261716AbSJASZ4>; Tue, 1 Oct 2002 14:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbSJASZ4>; Tue, 1 Oct 2002 14:25:56 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:50915 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261716AbSJASZx>;
	Tue, 1 Oct 2002 14:25:53 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: jbradford@dial.pipex.com
Date: Tue, 1 Oct 2002 20:30:44 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Stupid luser question
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <3624A9D2016@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Oct 02 at 19:14, jbradford@dial.pipex.com wrote:

> Just wondering, what is the purpose of the comment /* { */ which is found in various seemingly random places in the kernel:
> 
> # grep -F -r "/* { */" *
> 
> drivers/video/font_acorn_8x8.c:/* 7B */  0x0C, 0x18, 0x18, 0x70, 0x18, 0x18, 0x0C, 0x00, /* { */

Body of character "{"...

> drivers/scsi/scsi_syms.c:#if defined(CONFIG_SCSI_LOGGING)       /* { */
> drivers/scsi/scsi.c:#ifdef CONFIG_SCSI_LOGGING          /* { */
> drivers/scsi/scsi.c:#ifdef CONFIG_SCSI_LOGGING          /* { */
> drivers/message/fusion/mptbase.h:#ifdef __KERNEL__      /* { */
> drivers/message/fusion/mptscsih.c:#ifndef MPT_SCSI_USE_NEW_EH   /* { */
> drivers/message/fusion/mptscsih.c:#ifdef MPT_SCSI_USE_NEW_EH            /* { */
> drivers/message/fusion/mptscsih.c:#if 0         /* { */
> drivers/message/fusion/mptbase.c:#ifdef CONFIG_PROC_FS              /* { */

All these are for cooperation with editors which find matching 
brace/bracket/... for you:

#ifdef __KERNEL__   /* { */
...
#endif /* } __KERNEL__ */

and then you can quickly jump from ifdef to endif and back even in
editor which does not know about #if/ifdef/else/elif/ifndef/endif...
                                            Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                                                        
