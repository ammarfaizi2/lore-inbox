Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVBWXOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVBWXOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVBWXNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:13:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:5334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261687AbVBWXMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:12:55 -0500
Date: Wed, 23 Feb 2005 15:17:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Help tracking down problem --- endless loop in
 __find_get_block_slow
Message-Id: <20050223151756.22c8c48d.akpm@osdl.org>
In-Reply-To: <421D029E.8010600@zensonic.dk>
References: <4219BC1A.1060007@zensonic.dk>
	<20050222011821.2a917859.akpm@osdl.org>
	<20050223120013.GA28169@zensonic.dk>
	<20050223041036.5f5df2ff.akpm@osdl.org>
	<20050223130251.GA31851@zensonic.dk>
	<20050223120928.133778a4.akpm@osdl.org>
	<421D029E.8010600@zensonic.dk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas S. Iversen" <zensonic@zensonic.dk> wrote:
>
> > I'd be suspecting that the sector remapping is the cause of the problem. 
> > How is it implemented?
> 
> Quite simple actually. You're most welcome to see the code, but I have 
> just done a test like the one below. Never mind the performance figures, 
>   correctness comes as a very first priority. It does not block, cause 
> endless loops or anything funny if I take the filsystem out of the 
> question and access the raw devicemapped block device.
> 
> This should assert that it is not a fault in my code, right?

I don't know.   Can you describe how your driver implements the remapping?
