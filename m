Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSE2W4w>; Wed, 29 May 2002 18:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSE2W4v>; Wed, 29 May 2002 18:56:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30737 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315634AbSE2W4t>;
	Wed, 29 May 2002 18:56:49 -0400
Message-ID: <3CF55C3D.6030008@mandrakesoft.com>
Date: Wed, 29 May 2002 18:54:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, davej@suse.de
Subject: Re: [PATCH] intel-x86 model config cleanup
In-Reply-To: <20020529143544.GA2224@werewolf.able.es> <3CF53C03.5040301@mandrakesoft.com> <3CF53C34.2080300@mandrakesoft.com> <20020529224423.GA3174@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

>  
>
>Then for each model you would define its generic CONFIG_M<arch>, and
>the specific features not contained in the generic. And then define
>the rest of features based on generic.
>The CONFIG_M<arch> would serve as a flag for 'this cpu has all features
>of a generic xxx'.
>
>Or if you are worried about namespace pollution these could be named
>CONFIG_CPU_VENDOR_, CONFIG_CPU_, CONFIG_CPU_M.
>  
>


Your division of categories (snipped from above quoted) seems ok.

The basic thing to remember is that "generic_foo" or "cpu_intel_foo" 
options should very rarely, if ever, appear in the config.in or sources. 
 We simply want to use the generic or cpu-specific user selection to 
determine (a) compiler flags, (b) CONFIG_xxx symbols for specific CPU 
features and optimizations, [like CONFIG_X86_F00F_BUG] and maybe (c) 
enable and disable CPU-specific drivers.  (c) will be a special case, 
since very few drivers should require a specific CPU type... but some 
drivers simply don't work on 386.

    Jeff



