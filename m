Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbUKSHsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUKSHsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 02:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbUKSHsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 02:48:41 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:59681 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261284AbUKSHsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 02:48:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lsWItMlNfwndkMJ7Cq+5cd+9bUZZ1MtINkuSRUFjB7eGJOGRlFu4sS+pvHtBPNPY/9kZ7Ga1n3/vECV28x3TGR7stW4RymTVz+jc2X/xeEMpMrvzJyzmftAkLpEzSCKikc1ej6EoYTpeomXudTG643N6guTKi2EG9Fih0kHq250=
Message-ID: <21d7e9970411182348704d2f0@mail.gmail.com>
Date: Fri, 19 Nov 2004 18:48:39 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Ralf Gerbig <rge@quengel.org>
Subject: Re: 2.6.10-rc2-mm1 (8139too interrupt)
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87sm76q40b.fsf-news@hsp-law.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041116014213.2128aca9.akpm@osdl.org>
	 <87lld0rb2i.fsf-news@hsp-law.de>
	 <20041117110640.1c7ccccd.akpm@osdl.org>
	 <87actgt8zy.fsf-news@hsp-law.de> <87sm76q40b.fsf-news@hsp-law.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> investigating further, radeon.ko nukes the NIC / INT
> 

hmm I can't see what could be majorly different between 2.6.9-mm1 and
2.6.10-rc2-mm2 with the DRM apart from core/personality split and that
shouldn't affect the IRQ code I've just  reviewed it another time but
can see nothing in this area,

Can you try on 2.6.10-rc2-mm2 from runlevel 3
modprobe drm
echo 1 > /sys/module/drm/parameters/debug
modprobe radeon

and get the dmesg it should be a lot more verbose.. does the IRQ die
at this point? if not start X running and send me the X startup log
from /var/log and the dmesg..

Thanks,
Dave.
