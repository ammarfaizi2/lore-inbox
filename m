Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUIXSFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUIXSFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUIXSFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:05:13 -0400
Received: from smtp-107-backup.nerim.net ([62.4.16.107]:47378 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S268998AbUIXSEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:04:51 -0400
Date: Fri, 24 Sep 2004 20:05:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Michael Hunold <hunold-ml@web.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <20040924200503.652ccf8e.khali@linux-fr.org>
In-Reply-To: <41545421.5080408@web.de>
References: <414F111C.9030809@linuxtv.org>
	<20040921154111.GA13028@kroah.com>
	<41545421.5080408@web.de>
Reply-To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We like to have an completly isolated i2c adapter, where the device 
> driver can invite i2c drivers to connect an i2c client to. When the 
> connection is made, an "interface" pointer with client-specific data
> or function pointers can be provided.
> (...)
> - add a new NO_PROBE flag to struct i2c_adapter, so a particular
> adapter is never probed by anyone

I don't get it. If the adapter is isolated, there is no way the i2c-core
will probe it anyway. As Adrian Cox underlined, it should be far easier
and more efficient to separate these adapters from the main i2c adapters
list from the beginning than leaving them in the main list and then try
and prevent future probings using a flag.

Also, how does this proposal interact with the work on the i2c classes?
Although the classes carry more information than a simple flag or a
complete separation, both were/may be introduced to achieve the same
goal, isn't it?

Thanks,

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
