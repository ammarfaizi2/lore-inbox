Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbRGPSBt>; Mon, 16 Jul 2001 14:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbRGPSBj>; Mon, 16 Jul 2001 14:01:39 -0400
Received: from cmn2.cmn.net ([206.168.145.10]:20548 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S267470AbRGPSB3>;
	Mon, 16 Jul 2001 14:01:29 -0400
Message-ID: <3B532BB7.1050300@valinux.com>
Date: Mon, 16 Jul 2001 12:00:23 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: John Cavan <johnc@damncats.org>, linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> Why not do something similar to the aic7xxx driver? Place the old DRM in
>> code in a pre-X4.1.0 subdirectory, with a warning that it will become
>> obsolete as of 2.5, and bring in the new code. When you build the
>> kernel, you can then choose which DRM version you want and everybody is
>> happy.
> 
> 
> Thats certainly possible, Ideally you would want both module sets to 
> co-exist. That way the user can build all of DRM and get the right ones loading
> via modprobe
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Actually I have something like this pretty much working.  Unfortunately 
I was working on a project full time during the 4.1.0 release.  With the 
addition of this code, the old modules will coexist with newer modules.  
Basically the newer modules will have their version numbers appended to 
their names, this way a user can build all the drm modules, and things 
will just work.  Hopefully we can get a 4.1.1 release out soon which 
will do this.  This will make the 4.0 -> 4.1 have to be a compile time 
decision, but 4.1 -> 4.1.1 and higher will just coexist with each 
other.  I'm currently working out integrating this into the kernel 
build, and I should hopefully have a patch for Linus and Alan soon.

-Jeff

