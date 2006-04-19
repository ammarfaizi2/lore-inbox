Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWDSSae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWDSSae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDSSae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:30:34 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:4370 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751132AbWDSSad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:30:33 -0400
Date: Wed, 19 Apr 2006 20:30:31 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [PATCH] i2c-i801: Fix resume when PEC is used
Message-Id: <20060419203031.b20e967c.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.64.0604190918210.3701@g5.osdl.org>
References: <20060418140629.7cb21736.khali@linux-fr.org>
	<20060418170331.GA3915@jupiter.solarsys.private>
	<20060418211546.fa5a76df.khali@linux-fr.org>
	<20060419130857.7f2db2d4.khali@linux-fr.org>
	<Pine.LNX.4.64.0604190918210.3701@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> On Wed, 19 Apr 2006, Jean Delvare wrote:
> > The BIOS of the Tecra M2 doesn't like it when it has to reboot or
> > resume after the i2c-i801 driver has left the SMBus in PEC mode. The
> > most simple fix is to clear the PEC bit after after every transaction.

The same day, Linus Torvalds replied:
> Just wondering.. Wouldn't it make more sense to clear it when closing the 
> device or when shutting down, rather than after each transaction?

That's what my original patch was doing, but Mark M. Hoffman objected
that it didn't cover the case where the user hits the reset button.

Given that PEC is only rarely used, the slight performance impact isn't
an issue, so I'm fine with both patches.

-- 
Jean Delvare
