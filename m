Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUL3RYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUL3RYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 12:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUL3RYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 12:24:07 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:44935 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261677AbUL3RX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 12:23:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ioHQS/P7O2Gj6nJ9MJuASoJ9Nwf8q/Mns/oH0IKu+LLrdueFhH+PI1ys/8SQw4eeOCnmhJa+uwj0BOyGFhhvDWv1azNQIPkKod+SmYX5aqQbQlfRjZEx1CZ+DyL2NS9JHc4hM3oP9jwHu+iFPztSx7/+MNnHYiesPYYImnC7/KA=
Message-ID: <105c793f041230092344e152d7@mail.gmail.com>
Date: Thu, 30 Dec 2004 12:23:55 -0500
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Logitech PS/2 touchpad on 2.6.X not working along bottom and right sides.
In-Reply-To: <105c793f04123009183bcc7dd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <105c793f04122907116b571ebf@mail.gmail.com>
	 <cr16ho$eh1$1@tangens.hometree.net>
	 <105c793f041230080734d71c4a@mail.gmail.com>
	 <200412301203.44484.dtor_core@ameritech.net>
	 <105c793f04123009183bcc7dd1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And again, the previously-unforwarded-to-the-list bit.

-Andy


> Yes, you can. Booting with psmouse.proto=bare will force the touchpad
> into standard PS/2 mode. You may also try booting with
> psmouse.proto=imps and psmouse.proto=exps - maybe one of these 2 will
> give you virtual scrolling.
>
> If psmouse is compiled as a module you will have to add
>
>         options psmouse proto=bare
>
> to your /etc/modprobe.conf
>
> Btw, what device/protocol are you using in X? I'd advise setting it
> to "dev/input/mice" and "ExplorerPS/2" so if your touchad is indeed
> sending scroll events X would use them. Could you post your config,
> please?

I'm using the /dev/mouse device for X with protocol 'auto'.

Here's the relevant portion of my XF86Config:

Section "InputDevice"
        Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Protocol" "auto"
        Option      "Device" "/dev/mouse"
EndSection

Unfortunately, I'm not currently physically at the machine (I only
have ssh access currently), so I can't try this stuff right away.
However, I will try your suggestions when I'm next at the machine
later today.

(Also, I'm now realizing that my subject for this thread was wrong, so
I've edited it a bit.)
