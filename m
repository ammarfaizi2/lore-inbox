Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWDSQUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWDSQUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWDSQUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:20:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750891AbWDSQUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:20:22 -0400
Date: Wed, 19 Apr 2006 09:19:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
cc: Greg KH <greg@kroah.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [PATCH] i2c-i801: Fix resume when PEC is used
In-Reply-To: <20060419130857.7f2db2d4.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.64.0604190918210.3701@g5.osdl.org>
References: <20060418140629.7cb21736.khali@linux-fr.org>
 <20060418170331.GA3915@jupiter.solarsys.private> <20060418211546.fa5a76df.khali@linux-fr.org>
 <20060419130857.7f2db2d4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Apr 2006, Jean Delvare wrote:
> 
> The BIOS of the Tecra M2 doesn't like it when it has to reboot or
> resume after the i2c-i801 driver has left the SMBus in PEC mode. The
> most simple fix is to clear the PEC bit after after every transaction.

Just wondering.. Wouldn't it make more sense to clear it when closing the 
device or when shutting down, rather than after each transaction?

		Linus
