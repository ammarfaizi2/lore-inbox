Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVBWORJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVBWORJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 09:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVBWORJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 09:17:09 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:34347 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261490AbVBWORE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 09:17:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cU+wX+im5waiy3AWq8mjkigRSmaafKNDRL1aY5J+E9vKM9lANQtWb3v4vEMet84Cs2SRG/RREL3CnR9503fer47N+6/O2436WRiSTeTV7GQLLiEC31iIW89y7Z+KZFkHBH5SFx74kquSSt15Ed8nOaFXS70bun0r5FEoDkP9sak=
Message-ID: <d120d50005022306177069ffbe@mail.gmail.com>
Date: Wed, 23 Feb 2005 09:17:02 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Nils Kalchhauser <n.kalchhauser@vollwerbung.at>
Subject: Re: mouse still losing sync and thus jumping around
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <421C83A2.9040502@vollwerbung.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <421C83A2.9040502@vollwerbung.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005 14:22:42 +0100, Nils Kalchhauser
<n.kalchhauser@vollwerbung.at> wrote:
> Hi!
> 
> I still get the following messages and my mouse jumps around weirdly
> making work rather difficult regardless of which 2.6 kernel I use (tried
> 2.6.8, 2.6.9, 2.6.10, 2.6.11-rc2 with patch-see below, 2.6.11-rc4):
> 
> psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization, throwing
> 2 bytes away.
> psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization, throwing
> 2 bytes away.
> psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
> psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
> psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> 
> (using either the touchpad or the connected PS/2 mouse)
> 
> I tried the patch Dmitry Torokhov supplied in the message with subject
> "Re: Really annoying bug in the mouse driver" from Jan 27 which
> supposedly fixes this problem. unfortunately it only got worse.
> 

Hi,

There were 2 versions of the psmouse-resend patch, the first one was
indeed producing worse results, the second one should work better.
Could you please try grabbing the patch against 2.6.10 from here:

http://www.geocities.com/dt_or/input/2_6_10/

and letting me know if it gives better results.

Thanks!
 

-- 
Dmitry
