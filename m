Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132873AbRA3Ww5>; Tue, 30 Jan 2001 17:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRA3Wwr>; Tue, 30 Jan 2001 17:52:47 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:29451 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132873AbRA3Wwc>;
	Tue, 30 Jan 2001 17:52:32 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapath.net>
cc: linux-kernel@vger.kernel.org, Ruurd Reitsma <R.A.Reitsma@wbmt.tudelft.nl>,
        Norberto Pellicci <pellicci@home.com>
Subject: Re: 2.4.1 -- Unresolved symbols in radio-miropcm20.o 
In-Reply-To: Your message of "Tue, 30 Jan 2001 13:08:12 -0800."
             <3A772D3C.CB62DD4F@megapath.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jan 2001 09:52:26 +1100
Message-ID: <4987.980895146@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 13:08:12 -0800, 
Miles Lane <miles@megapath.net> wrote:
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.1/kernel/drivers/media/radio/radio-miropcm20.o
>depmod: 	aci_write_cmd
>depmod: 	aci_indexed_cmd
>depmod: 	aci_write_cmd_d

Those symbols are defined in drivers/sound/aci.c but are not exported
for other modules to use.  The aci and miropcm20 code needs to be
changed to support use as modules.  Also the config.in files need
fixing for these files, it is possible to select combinations of aci
and miropcm20 that will fail to link (miropcm20 built in, aci not
selected or selected as a module) or fail to load (miropcm20 selected
as a module, aci not selected).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
