Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319343AbSIFTVm>; Fri, 6 Sep 2002 15:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319346AbSIFTVm>; Fri, 6 Sep 2002 15:21:42 -0400
Received: from ns.suse.de ([213.95.15.193]:31748 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319343AbSIFTVl>;
	Fri, 6 Sep 2002 15:21:41 -0400
Date: Fri, 6 Sep 2002 21:26:19 +0200
From: Andi Kleen <ak@suse.de>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <20020906212619.A28172@wotan.suse.de>
References: <3D78C9BD.5080905@us.ibm.com> <53430559.1031304588@[10.10.2.3]> <3D78E7A5.7050306@us.ibm.com> <20020906202646.A2185@wotan.suse.de> <1031339954.3d78ffb257d22@imap.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031339954.3d78ffb257d22@imap.linux.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you just wanted to speed things up, you could get the
> clients to specify ports instead of letting the kernel
> cycle through for a free port..:)

Better would be probably to change the kernel to keep a limited
list of free ports in a free list. The grabbing a free port would
be an O(1) operation. 

I'm not entirely sure it is worth it in this case. The locks are
probably the majority of the cost.

-Andi
