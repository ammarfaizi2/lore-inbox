Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVBQNvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVBQNvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVBQNvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:51:23 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:64479 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261874AbVBQNvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:51:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DtSdRuDkdKAqCRDSdfe9YmK3M71sW4gpZY9fbNo5hfOx//O8WPbX4nH/N2FhjkhKGug/A4Qbg4RivOdCjW8GFdEKA/c+Lja9tQQnZr6GjZ0rYzYNN7V2ag5AwGA/irC2JhIVjHnSqbkOq4ceet67Mh7pphMNm4K0TAIRwIK2qAI=
Message-ID: <d120d50005021705511a5afe25@mail.gmail.com>
Date: Thu, 17 Feb 2005 08:51:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Michael Brade <brade@informatik.uni-muenchen.de>
Subject: Re: 2.6.11-rc4: touch pad misidentified (ALPS instead of ImPS/2)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200502171337.58081.brade@informatik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502171337.58081.brade@informatik.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005 13:37:55 +0100, Michael Brade
<brade@informatik.uni-muenchen.de> wrote:
> Hi,
> 
> the new 2.6.11-rc series has another problem for me, my touchpad (Toshiba
> Laptop) stopped working. I guess this has to do with "[PATCH] ALPS touchpad
> detection fix" that was posted about 4 weeks ago. The kernel says while
> booting:
> 
> newton kernel: mice: PS/2 mouse device common for all mice
> newton kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
> newton kernel: ALPS Touchpad (Glidepoint) detected
> newton kernel:   Disabling hardware tapping
> newton kernel: input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> 
> and when I try to use it, the following is spit out:
> 
> last message repeated 2 times
> kernel: psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> kernel: psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> last message repeated 2 times
> kernel: psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> kernel: psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
>

Hi,

Could you please boot with "i8042.debug log_buf_len=131072" boot
option, work touchpad a bit and send me your full dmesg (or
/var/log/messages), please?

I the meantime to get your touchpad working (after you send me the
dmesg) add "psmouse.proto=exps" to your boot options (or add "options
psmouse proto=exps" if psmouse is compiled as a module).

-- 
Dmitry
