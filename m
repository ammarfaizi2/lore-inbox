Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTIQOab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 10:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTIQOab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 10:30:31 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:5800 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262770AbTIQOa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 10:30:29 -0400
Subject: Re: (Possible Fix) MS-PNR SCSI Card / NCR5380 SCSI Driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wagner Volanin <fadinha.mail@terra.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <HLBOOL$9F22A6BA6BDFE9CEF6137FE62345D3D3@terra.com.br>
References: <HLBOOL$9F22A6BA6BDFE9CEF6137FE62345D3D3@terra.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063808934.12270.57.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Wed, 17 Sep 2003 15:28:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-16 at 20:55, Wagner Volanin wrote:
> Why the function NCR5380_poll_politely() returned the value 'r'
> on success if this value should be '0' case everything went ok...

That looks correct. Its been a long time since I attacked this driver
though, an although I had it working beautifully in 2.5.30 or so its
rotted back into nonfunctioning with the later 2.5 scsi changes.

> So I changed "return r;" to "return 0;" and after that my
> scanner worked fine, and was easily detected by SANE, without
> a single error message.  :)

It looks right to me.

