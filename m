Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263076AbTDBRbp>; Wed, 2 Apr 2003 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263087AbTDBRbp>; Wed, 2 Apr 2003 12:31:45 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:6653 "EHLO
	columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S263076AbTDBRar>; Wed, 2 Apr 2003 12:30:47 -0500
Message-ID: <3E8B20F0.1090307@jburgess.uklinux.net>
Date: Wed, 02 Apr 2003 18:42:08 +0100
From: Jon Burgess <mplayer@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: Martin Murray <mmurray@deepthought.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: accessing ROM on Rage 128 chips in aty128fb
References: <3E88862C.10205@uklinux.net> <Pine.LNX.4.53.0304021215090.24044@gallium.deepthought.org>
In-Reply-To: <Pine.LNX.4.53.0304021215090.24044@gallium.deepthought.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Murray wrote:

> the pci code to do this from a driver, if pci=rom was not used?
  - see below

> This worked, I realized that I was chasing the wrong bug - the code to
> find the BIOS was looking for a "R128" signature, where my mobile Rage 128
> has an "M3" signature. I patched the driver to search for "M3" as well as

Take a look at the latest code in linux-2.5.66/drivers/video/aty/aty128fb.c

It no longer looks specifically for "R128". Also see the function 
aty128_map_ROM() for an example of how the ROM resource assigned 
automatically in the latest code.

You could add this to the 2.4 code or try 2.5. I imagine the new driver 
code will eventually get backported to 2.4 once it is considered stable.

	Jon



