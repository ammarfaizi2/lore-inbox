Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTFFRXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTFFRXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:23:23 -0400
Received: from wks1.stratum8.com ([64.186.168.130]:14086 "EHLO
	sd-exchange.sdesigns.com") by vger.kernel.org with ESMTP
	id S262100AbTFFRXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:23:22 -0400
Message-ID: <9F77D654ED40B74CA79E5A60B97A087B07C314@sd-exchange.sdesigns.com>
From: Ho Lee <Ho_Lee@sdesigns.com>
To: "'Stephan von Krawczynski'" <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: How to turn off ide dma ...
Date: Fri, 6 Jun 2003 10:42:38 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I misunderstood it. In that case, hdx=noautotune (x=[a..d]) would work. 
It disables autotuning the drive, so the ide_dma_check method of DMA
procedure is not called. Eventually Linux doesn't check whether the
drive is DMA capable or not, and use PIO mode for the drive. 

Regards,
Ho

-----Original Message-----
From: Stephan von Krawczynski [mailto:skraw@ithnet.com]
Sent: Friday, June 06, 2003 10:21 AM
To: Ho Lee
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to turn off ide dma ...


On Fri, 6 Jun 2003 10:22:52 -0700 
Ho Lee <Ho_Lee@sdesigns.com> wrote:

> 
> ide=nodma option would help you. It disables DMA on every
> IDE interfaces. 

Thanks, I know that. My problem is disabling DMA on _certain_ ide devices,
while others remain with DMA enabled. How do you do that?

Regards,
Stephan
