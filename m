Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWA3KZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWA3KZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWA3KZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:25:38 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41660 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751272AbWA3KZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:25:38 -0500
Date: Mon, 30 Jan 2006 11:25:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing filesystem
In-Reply-To: <1138614856.2977.16.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0601301114160.25336@yvahk01.tjqt.qr>
References: <87ek3a8qpy.fsf@goat.bogus.local>  <200601231257.28796@bilbo.math.uni-mannheim.de>
  <87mzhgyomh.fsf@goat.bogus.local> <20060128150137.5ba5af04.akpm@osdl.org>
  <Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr>  <20060130011630.60f402d8.akpm@osdl.org>
  <Pine.LNX.4.61.0601301024150.6405@yvahk01.tjqt.qr> 
 <1138614388.2977.10.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0601301050260.6405@yvahk01.tjqt.qr>
 <1138614856.2977.16.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You can't do that.
>
>Exactly why not? Assuming there are zero users left in the kernel.....
>(which highly obviously is a prerequisite for even thinking about such a
>step)

   Documentation/mutex-design.txt:
   * - mutexes may not be used in irq contexts

I need some locking strategy within irq contexts, and that suggests 
semaphores do the job.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
