Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbUAUNJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 08:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAUNJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 08:09:34 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:27042 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265401AbUAUNJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 08:09:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andi Kleen <ak@suse.de>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Subject: Re: mouse configuration in 2.6.1
Date: Wed, 21 Jan 2004 08:09:25 -0500
User-Agent: KMail/1.5.4
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       vojtech@suse.cz
References: <p73r7xwglgn.fsf@verdi.suse.de> <Pine.LNX.4.58.0401211228300.25485@student.dei.uc.pt> <20040121134204.73e6450f.ak@suse.de>
In-Reply-To: <20040121134204.73e6450f.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401210809.25187.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 January 2004 07:42 am, Andi Kleen wrote:
> On Wed, 21 Jan 2004 12:31:21 +0000 (WET)
>
> "Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
> > apparently:
> > > psmouse_base.psmouse_proto=bare
> >
> > Actually it's psmouse.proto=bare
>
> In 2.6.1 it is definitely psmouse_base.psmouse_proto=bare
>

You really should see psmouse.psmouse_proto=bare in 2.6.1 (and it's
changed to psmouse.proto=bare in 2.6.2-rc1):

make KBUILD_MODULES=1 -f scripts/Makefile.build obj=drivers/input/mouse
  gcc -Wp,-MD,drivers/input/mouse/.psmouse-base.o.d -nostdinc -iwithprefix
  include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  
  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
  -pipe -mpreferred-stack-boundary=2 -march=pentium3
  -Iinclude/asm-i386/mach-default -O2
  -DMODULE -DKBUILD_BASENAME=psmouse_base -DKBUILD_MODNAME=psmouse 
  -c -o drivers/input/mouse/.tmp_psmouse-base.o 
  drivers/input/mouse/psmouse-base.c

As you can see KBUILD_MODNAME is just psmouse and module_param() uses it
as a prefix.

-- 
Dmitry
