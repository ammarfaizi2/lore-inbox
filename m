Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273186AbRIPIrn>; Sun, 16 Sep 2001 04:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273189AbRIPIrd>; Sun, 16 Sep 2001 04:47:33 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:56585 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S273186AbRIPIrT>;
	Sun, 16 Sep 2001 04:47:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] modutils: ieee1394 device_id extraction 
In-Reply-To: Your message of "15 Sep 2001 18:02:10 +0200."
             <m38zfgmohp.fsf@dk20037170.bang-olufsen.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Sep 2001 18:46:37 +1000
Message-ID: <29177.1000629997@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Sep 2001 18:02:10 +0200, 
Kristian Hogsberg <hogsberg@users.sf.net> wrote:
>I've been adding hotplug support to the ieee1394 subsystem, and the
>ieee1394 stack in cvs now calls the usermode helper just like usb, pci
>and the rest of them.  Next step is to extend depmod so it extracts
>the device id tables from the 1394 device drivers, which is exactly
>what the patch below does.
>
>Keith, would you apply this to modutils?

Patch looks OK, expect that sometimes you use hpsb and sometimes
ieee1394 as a prefix for variable names.  Can they all be iee1394,
including the device table?  Use MODULE_DEVICE_TABLE(ieee1394,name)
instead of MODULE_DEVICE_TABLE(hpsb, name).

