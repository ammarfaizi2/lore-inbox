Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270571AbRHITsr>; Thu, 9 Aug 2001 15:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270570AbRHITsh>; Thu, 9 Aug 2001 15:48:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23048 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270574AbRHITse>; Thu, 9 Aug 2001 15:48:34 -0400
Subject: Re: Linux 2.4.7-ac10
To: eiki.hjartarson@wanadoo.dk
Date: Thu, 9 Aug 2001 20:50:21 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010809214645.A510@pluto.home> from "Eirikur Hjartarson" at Aug 09, 2001 09:46:45 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Uvoz-0007xI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 08, 2001 at 07:51:34PM +0100, Alan Cox wrote:
> > ...
> > o	Fix a bug in access() checks on X_OK with	(Christoph Hellwig)
> > 	DAC ovveride
> 
> root can no longer execute files it does not have access to, e.g.

Ok thats not quite correct behaviour.

> pluto -# ls -l /sbin/getty
> -r-x------    1 bin      bin         32784 Aug  8 06:54 /sbin/getty
> pluto -# /sbin/getty
> bash: /sbin/getty: Permission denied
> pluto -# chmod go+rx /sbin/getty

Right. The DAC stuff needs a bit of a different approach then
