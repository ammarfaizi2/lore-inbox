Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVCBWOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVCBWOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVCBWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:10:45 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:30683 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262500AbVCBWIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:08:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Fc9MV7Z4omerPxDihGMDuBxwwJJb6nJoiUbz0wO9FUNNS35jNRrr2LdmNnb5WcLEx2ILW35oPQe5KwFc2cJRxMeIpagk8n4eCDa/MjFk6deVTq1L0gTxTu/H9mDMcKy+H6s4JGHML69kkV7TLjcn/f19TdfBkRyCkRILYtVKPhw=
Message-ID: <d120d50005030214086b6d568e@mail.gmail.com>
Date: Wed, 2 Mar 2005 17:08:35 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Subject: Re: 2.6.11: touchpad unresponsive
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42260B1D.3070304@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3d668208.82083d66@teleline.es>
	 <d120d50005030209123b8db1ae@mail.gmail.com>
	 <42260B1D.3070304@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 19:51:09 +0100, Miguelanxo Otero Salgueiro
<miguelanxo@telefonica.net> wrote:
> Dmitry Torokhov wrote:
> 
> >On Wed, 02 Mar 2005 16:55:59 +0100, MIGUELANXO@telefonica.net
> ><MIGUELANXO@telefonica.net> wrote:
> >
> >
> >>I just compiled 2.6.11 from 2.6.10 config using 'make oldconfig',
> >>activate new options to default values (i.e. set "main kernel lock
> >>preemtive" to YES).
> >>
> >>Booting X in new kernel makes my touchpad very unresponsive. I can't
> >>click any longer in the touchpad area, and the touchpad doesn't response
> >>when moving in small increments, so the whole experience is quite bad.
> >>
> >>
> >>
> >
> >If it is identified as an ALPS touchpad you can try installing Peter
> >Osterlund's Synaptics X driver:
> >
> >           http://web.telia.com/~u89404340/touchpad/
> >
> >Alternatively you can restore 2.6.10 behavior with psmouse.proto=exps
> >boot option (if psmouse is a module add "options psmouse proto=exps"
> >to your /etc/modprobe.conf).
> >
> >
> >
> Yes, it's an ALPS touchpad.
> 
> Ok, I compiled latest synaptics driver (synaptics-0.14.0) under the
> following conditions
>    - Enabled CONFIG_MOUSE_PS2 (already enabled)
>    - Enabled CONFIG_INPUT_EVDEV (this one on purpose)
> 
> I read README.alps so I tried patching the kernel with alps.patch as
> suggested. Looks like it didn't work because patch refused to patch
> already patched files. I gave a look at the patch and the kernel code,
> and they seem to be incompatible (maybe you need to release a newe patch).
> 
> So I proceded without the patched kernel, installing the synaptics
> driver using INSTALL and README.alps settings.
> 
> With plain INSTALL settings (no ALPS), the touchpad seemed responsible,
> but kind of slow. Simple or double click didn't work.
> 
> With README.alps settings, touchpad feels a lot like in 2.6.10, thought
> the "acceleration" seems to be non-linear.
> Simple click worked BUT double-click didn't work. Horizontal/Vertical
> scroll and Click-n-Drag worked too, so I'm almost there.
> 

There are more paches done by Peter in the input queue that should
improve ALPS tapping behaviour. Maybe Peter will add them to his
driver for time being.

> 
> By the way, I'm using a Toshiba laptop (Toshiba Satellite A10), maybe
> you would like to add that to your supported hardware list.
> 

Please let Peter (petero2@telia.com) know as he maintains the driver/site.

-- 
Dmitry
