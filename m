Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWAHW7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWAHW7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbWAHW7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:59:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:44959 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161226AbWAHW7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:59:38 -0500
Subject: Re: i2c/ smbus question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20060108113013.34fe5447.khali@linux-fr.org>
References: <1136673364.30123.20.camel@localhost.localdomain>
	 <20060108113013.34fe5447.khali@linux-fr.org>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 09:58:22 +1100
Message-Id: <1136761102.30123.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 11:30 +0100, Jean Delvare wrote:

> The i2c_smbus_write_i2c_block_data wrapper function used to be defined,
> but was removed in 2.6.10-rc2 together with a couple other similar
> wrappers [1] on request by Adrian Bunk, the reason being that they had
> no user back then. I was a bit reluctant at first, but we finally agreed
> with Adrian to remove the functions, and to reintroduce them later if
> they were ever needed.

Argh... Adrian, sometimes I hate you ;-)

> So, if you need i2c_smbus_write_i2c_block_data(), we can easily
> resurrect it. See the patch below. I made the new version a bit faster
> (I hope) than the original by using memcpy, please confirm it works for
> you.

Seems to work. Greg, would you mean boucing that to Linus asap (if you
are ok with it of course) ? I have a pile of patch about to hit him via
the powerpc merge git tree and I'll "fix" some of the mac drivers in
there to use that wrapper, so without that patch, g5 won't build ;)

Thanks !

Ben.


