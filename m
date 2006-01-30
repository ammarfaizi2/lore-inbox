Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWA3Kgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWA3Kgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWA3Kgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:36:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54737 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932203AbWA3Kgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:36:32 -0500
Date: Mon, 30 Jan 2006 11:36:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing filesystem
In-Reply-To: <1138617073.2977.21.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0601301135540.12495@yvahk01.tjqt.qr>
References: <87ek3a8qpy.fsf@goat.bogus.local>  <200601231257.28796@bilbo.math.uni-mannheim.de>
  <87mzhgyomh.fsf@goat.bogus.local> <20060128150137.5ba5af04.akpm@osdl.org>
  <Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr>  <20060130011630.60f402d8.akpm@osdl.org>
  <Pine.LNX.4.61.0601301024150.6405@yvahk01.tjqt.qr> 
 <1138614388.2977.10.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0601301050260.6405@yvahk01.tjqt.qr> 
 <1138614856.2977.16.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0601301114160.25336@yvahk01.tjqt.qr>
 <1138617073.2977.21.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>well... maybe.
>If you need to mess inside irq context, spinlocks sound more the right
>thing. Or if you need to do a "I'm done" in the irq and a "sleep until
>done" thing in process context, then you really should use completions
>instead.

Hm, is it allowed to call copy_{from,to}_user() in irq context?



Jan Engelhardt
-- 
