Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSLQMZK>; Tue, 17 Dec 2002 07:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSLQMZK>; Tue, 17 Dec 2002 07:25:10 -0500
Received: from ns.suse.de ([213.95.15.193]:56592 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264975AbSLQMZJ>;
	Tue, 17 Dec 2002 07:25:09 -0500
Date: Tue, 17 Dec 2002 13:33:07 +0100
From: Dave Jones <davej@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Message-ID: <20021217133307.A18730@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au
References: <200212162049.16039.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212162049.16039.tomlins@cam.org>; from tomlins@cam.org on Mon, Dec 16, 2002 at 08:49:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 08:49:16PM -0500, Ed Tomlinson wrote:
 > I am getting the above message in 2.5.51, 52, and 52+bk current.  
 > Pci info follows:
 > 
 > What else would help to debug this?  The drm error above is all I find in the logs...

There are a bunch of pending fixes at bk://linux-dj.bkbits.net/agpgart,
but nothing that should be relevant to this problem.
Are you using agpgart as modules? Which ones loaded ?
I've a feeling agpgart.ko loaded here, but not via-agp.ko

What needs to happen is when agpgart.ko is loaded, all the
chipset drivers also get pulled in as dependancies.
Since the new module stuff went in, I'm not sure how this
works, if it works at all.[1]

        Dave

[1] I'm yet another developer who has had a rough time with the
    new modules stuff. I'll try it again soon.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
