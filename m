Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUIVPlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUIVPlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 11:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUIVPlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 11:41:10 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:11275 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266169AbUIVPk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 11:40:56 -0400
Message-ID: <9e47339104092208403d9de6f4@mail.gmail.com>
Date: Wed, 22 Sep 2004 11:40:35 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Cc: Adrian Cox <adrian@humboldt.co.uk>, Michael Hunold <hunold-ml@web.de>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20040922122848.M14129@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>
	 <41506099.8000307@web.de> <41506D78.6030106@web.de>
	 <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org>
	 <1095854048.18365.75.camel@localhost>
	 <20040922122848.M14129@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 14:38:46 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> Aha, this is an interesting point (which was missing from your previous
> explanation). The base of your proposal would be to have several small i2c
> "trees" (where a tree is a list of adapters and a list of clients) instead of
> a larger, unique one. This would indeed solve a number of problems, and I
> admit that it is somehow equivalent to Michael's classes in that it
> efficiently prevents the hardware monitoring clients from probing the video
> stuff. The rest is just details internal to each "tree". As I understand it,
> each video device would be a tree on itself, while the whole hardware
> monitoring stuff would constitute one (bigger) tree. Correct?

Any DDC solution needs to leave the data visible in sysfs and
accessible from user space. I'm trying to move the EDID parsing code
out of the kernel.

-- 
Jon Smirl
jonsmirl@gmail.com
