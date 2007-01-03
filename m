Return-Path: <linux-kernel-owner+w=401wt.eu-S1754905AbXACHgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbXACHgr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbXACHgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:36:47 -0500
Received: from www17.your-server.de ([213.133.104.17]:1859 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905AbXACHgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:36:46 -0500
Message-ID: <459B5CAA.6080600@m3y3r.de>
Date: Wed, 03 Jan 2007 08:35:06 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.9 (X11/20061222)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: WARNING: Absolute relocations present
References: <458BECA8.2080807@m3y3r.de> <20070103055312.GA25433@in.ibm.com>
In-Reply-To: <20070103055312.GA25433@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal schrieb:
> What's your ld version. I don't remember but some particular versions
> of ld will have this problem. These ld versions do some optimizations
> and if a section size is zero then linker gets rid of that section and
> any symbol defined w.r.t removed section, ld makes that symbol absolute
> instead of section relative. That's why you see above warnings. 
>
> I had raised this issue on binutils mailing list and they fixed it.
>
> http://sourceware.org/ml/binutils/2006-09/msg00305.html
>
> I am using following ld version and it works fine for me.
>
> GNU ld version 2.17.50.0.6-2.el5 20061020
>  
> So you will have to move to the latest ld version and problem should be
> resolved.
>   
Correct. I'm using binutils version 2.17. This is the current testing 
branch of gentoo for x86.
