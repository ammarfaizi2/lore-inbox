Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVKUPnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVKUPnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVKUPnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:43:19 -0500
Received: from rtr.ca ([64.26.128.89]:26003 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932321AbVKUPnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:43:19 -0500
Message-ID: <4381EB1B.5040105@rtr.ca>
Date: Mon, 21 Nov 2005 10:43:23 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
References: <437F63C1.6010507@perkel.com> <437FCA07.40600@superbug.co.uk>
In-Reply-To: <437FCA07.40600@superbug.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the hdparm -y, -Y, and -S flags all work with the passthru feature set,
which is included in the 2.6.15-rc* kernels.

Typical power consumption figures, from WDC SataII drives:

Idle:  430mA@12VDC + 730mA@5VDC (about 8.75 watts)
Standby:  20mA@12VDC + 270mA@5VDC (about 1.60 watts)
Sleep: 20mA@12VDC + 250mA@5VDC (about 1.50 watts)

Those are from the WDC datasheets.

Cheers
