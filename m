Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWFVRgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWFVRgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbWFVRgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:36:18 -0400
Received: from [212.76.84.205] ([212.76.84.205]:53257 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751855AbWFVRgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:36:03 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Incorrect CPU process accounting using CONFIG_HZ=100
Date: Thu, 22 Jun 2006 20:36:39 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200606211716.01472.a1426z@gawab.com> <Pine.LNX.4.61.0606220741540.25261@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606220741540.25261@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200606222036.39908.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> >Setting CONFIG_HZ=100 results in incorrect CPU process accounting.
> >
> >This can be seen running top d.1, that shows top, itself, consuming 0ms
> >CPUtime.
> >
> >Will this bug have consequences for sched.c?
>
> Works for me, somewhat.
> TIME+ says 0:00.02 after 70 secs. (Ergo: top is not expensive on this
> CPU.)

That's what I thought for a long time.  But at closer inspection, top d.1 
slows down other apps by about the same amount of time at 1000Hz and 100Hz, 
only at 1000Hz it is accounted for whereas at 100Hz it is not.

Thanks!

--
Al

