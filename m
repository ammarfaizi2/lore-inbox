Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269826AbUH0A7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269826AbUH0A7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269794AbUH0AyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:54:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19627 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269757AbUHZXwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:52:30 -0400
Message-ID: <412E77BE.5070005@namesys.com>
Date: Thu, 26 Aug 2004 16:52:30 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Spam <spam@tnonline.net>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com>	<20040825152805.45a1ce64.akpm@osdl.org>	<112698263.20040826005146@tnonline.net>	<Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>	<1453698131.20040826011935@tnonline.net>	<20040825163225.4441cfdd.akpm@osdl.org>	<20040825233739.GP10907@legion.cup.hp.com>	<20040825234629.GF2612@wiggy.net>	<1939276887.20040826114028@tnonline.net>	<20040826024956.08b66b46.akpm@osdl.org>	<839984491.20040826122025@tnonline.net>	<20040826032457.21377e94.akpm@osdl.org>	<742303812.20040826125114@tnonline.net> <20040826035500.00b5df56.akpm@osdl.org>
In-Reply-To: <20040826035500.00b5df56.akpm@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>No.  All of the applications which you initially identified can be
>implemented by putting the various bits of data into a single file and
>getting applications to agree on the format of that file.
>
>For example, some image file formats already support embedded metadata, do
>they not?
>
>-
>  
>
and that leads to vasts numbers of file formats, all of which require 
special code to parse them, and apps that don't duplicate that code 
can't access the data, and it is a software engineering mistake.  
Uniform interfaces greatly reduce the cost of an OS and increase its 
expressive power.  Closure is the most important and least understood 
principle of OS design.

By contrast, suppose everything was stored in files and directories.  
Every app can afford the coding cost to learn about files and 
directories.  Data can freely bounce from one object to another in the 
OS because the APIs for the objects are all the same.  That's increased 
expressive power.  The number of connections between objects determines 
the expressive power of the OS, not the number of objects in it.  
Unified namespaces do a lot for an OS.

Hans
