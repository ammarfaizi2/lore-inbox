Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbUBJSNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUBJRxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:53:45 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:10448 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266159AbUBJRw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:52:57 -0500
Message-ID: <40291A73.7050503@nortelnetworks.com>
Date: Tue, 10 Feb 2004 12:52:51 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Bell <kernel@mikebell.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca>
In-Reply-To: <20040210171337.GK4421@tinyvaio.nome.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Bell wrote:

> No, you misunderstand. I'm not suggesting that sysfs /should/ export
> device files. I'm saying that sysfs exporting type/major/minor as files
> is not really that different from exporting full-fledged device files.
> Making udev a sort of ugly-hack devfsd.

What names would you use for your device files?  This is the key 
difference.  With udev it gets a notification that says "I have a new 
block device", it then looks it up, applies the rules, and creates a new 
entry.  The whole point is to move the naming scheme into userspace for 
easier management.

You could have the kernel export a simple devfs with a hardcoded naming 
scheme based on similar ideas as what is in sysfs (which would then make 
sysfs and the daemon optional for tiny embedded setups), but the only 
advantage over just exporting the information in sysfs is to save a few 
bytes at the cost of yet another filesystem to maintain.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
