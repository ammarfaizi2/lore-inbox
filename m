Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSCRS0m>; Mon, 18 Mar 2002 13:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSCRS0c>; Mon, 18 Mar 2002 13:26:32 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:64530 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S291547AbSCRS0S>; Mon, 18 Mar 2002 13:26:18 -0500
Message-Id: <200203181828.g2IISuI07488@aslan.scsiguy.com>
To: Andrey Slepuhin <pooh@msu.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver v6.2.5 freezes the kernel 
In-Reply-To: Your message of "Mon, 18 Mar 2002 19:24:30 +0300."
             <20020318192430.B8849@glade.nmd.msu.ru> 
Date: Mon, 18 Mar 2002 11:28:56 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I tracked the problem down to ahc_read_seeprom(), which hangs in
>CLOCK_PULSE() at aic7xxx_93cx6.c:161. But I have no idea what happens,
>because this code is the same as in 6.2.4 version of the driver.

Is the driver using memory mapped I/O with the new driver but I/O
mapped in the old?  I will add a timeout to the CLOCK_PULSE() code,
but that still doesn't explain why the hang is happening now.

--
Justin
