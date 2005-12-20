Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVLTM6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVLTM6d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 07:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVLTM6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 07:58:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61705 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750988AbVLTM6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 07:58:33 -0500
Date: Tue, 20 Dec 2005 13:58:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051220125831.GA6789@stusta.de>
References: <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de> <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net> <43A694DF.8040209@aitel.hist.no> <A3567036-A5F9-4CF9-BC48-70CFEAA8F2C4@comcast.net> <1135014201.10933.4.camel@localhost> <B1D5AEA1-A120-4997-AD9A-A2379B6A1779@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1D5AEA1-A120-4997-AD9A-A2379B6A1779@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 02:10:17PM -0500, Parag Warudkar wrote:
>...
> How do you determine how much stack space a piece of code is going to  
> need without knowing what functionality it needs to build? There  
> might be deeply nested, long call chains etc. which certain types of  
> functionality might warrant.

Static analysis of this problem is possible.

"make checkstack" is a good starting point.

And the automatic analysis of all possible call chains can and has 
already found problems.

> How do you prove "4K otta be enough  
> stack for everyone doing everything", on what basis? (Reminds me of  
> old DOS days and the famous statement relating to 640K)
>...

We are talking about reducing the stack size by one third which doesn't 
result in a fundamental difference.

There is no technical reason why 4 kB shouldn't be enough - I don't 
count sloppy coding as a reason for it since in such cases we better 
correct the code.

> Parag

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

