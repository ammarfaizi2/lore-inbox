Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUBKJbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 04:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUBKJbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 04:31:20 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:43026 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263805AbUBKJbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 04:31:19 -0500
Message-ID: <4029F96A.6050105@aitel.hist.no>
Date: Wed, 11 Feb 2004 10:44:10 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mike Bell <kernel@mikebell.org>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
References: <20040210113417.GD4421@tinyvaio.nome.ca> <4028DA93.9060107@aitel.hist.no> <20040210160011.GJ4421@tinyvaio.nome.ca>
In-Reply-To: <20040210160011.GJ4421@tinyvaio.nome.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Bell wrote:
> On Tue, Feb 10, 2004 at 02:20:19PM +0100, Helge Hafting wrote:
> 
>>Non-devfs setups (with or without udev) support a similiar trigger
>>mechanism for module loading, that is simpler to set up and understand.
>>And that is a persistend device node.  Plain, simple, and ls sees it too.
>>Open it and the device is loaded as needed.  And at open time, not
>>at lookup time.  Load at lookup time might not be necessary, after all.
> 
> 
> This doesn't work anymore if you move to dynamic device numbers, nor
Sure.  Completely random device numbers will make this demand loading of 
device drivers impossible. Either it won't happen (all numbers won't be 
completely random, although they may get more dynamic than today) or
module loading based on device node opening will be deprecated.

This won't mean the end of dynamic loading, you will merely need to
load modules explicit before you get a device node.  

> does it work cleanly if /dev is on tmpfs or something else that doesn't
> persist between reboots (that's one of the things I like about devfs,
> being able to use it with a RO root.)
Still possible. Boot script (possibly the udev startup script)
copies a handful of device nodes from the RO root into the tmpfs /dev.  

Helge Hafting

