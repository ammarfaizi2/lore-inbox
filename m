Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289375AbSBELGX>; Tue, 5 Feb 2002 06:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289380AbSBELGN>; Tue, 5 Feb 2002 06:06:13 -0500
Received: from smtp01.web.de ([194.45.170.210]:30220 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S289375AbSBELF7>;
	Tue, 5 Feb 2002 06:05:59 -0500
Message-ID: <3C5FBA17.8020601@web.de>
Date: Tue, 05 Feb 2002 11:55:19 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020104
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
CC: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-dj2
In-Reply-To: <20020204154800.A13519@suse.de>	<1012841649.8335.6.camel@regatta> <20020204194719.C11789@suse.de>	<1012854899.8333.12.camel@regatta>  <20020204220602.E11789@suse.de> <1012856697.8335.20.camel@regatta>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

hmm, the zisofs again. I think that's caused because the compress.o 
module gets included at a pretty late stage in the Makefile ( 
fs/isofs/Makefile ) for linking. From what I've seen in other Makefiles, 
all modules that export symbols are linked into the target object first. 
Please query the lkml message list for a previous mail from me with 
subject "2.5.3-dj1: fast zisofs compile fix". It has a small patch for 
that particular Makefile that moves compress.o at the beginning of the 
link list if zisofs is included. Not sure this is the right way, but it 
works.

Regards,
            Todor

