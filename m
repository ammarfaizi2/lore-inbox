Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271704AbTHOWbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272057AbTHOWbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:31:24 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:11015 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271704AbTHOWbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:31:23 -0400
Date: Fri, 15 Aug 2003 23:31:20 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Otto Solares <solca@guug.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBDEV updates.
In-Reply-To: <1060936833.13534.34.camel@gaston>
Message-ID: <Pine.LNX.4.44.0308152319570.30952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That patch actually works here and I'm more/less waiting for it
> to be merged so I can send you the driver updates based on it.
> (It's becoming rather urgent. My pending PowerMac updates that
> port things to the new model are causing PM to break on PowerBook
> laptops now because fbdev has incorrect PM and the "old style" thing
> isn't properly ordered).
> 
> The only thing you may probably want to fix (because you know
> that code better than I do) are:
> 
>  - the "resume" callback in fbcon where I currently just refresh
> the foreground console, while you may actually want to refresh the
> one on this fb since I suppose that with mutiple heads, we may have
> consoles on more than one head ?
> 
>  - the suspend callback where you probably want to disable the
> cursor timer

Will do. I like to also handle Video mode change. Even userland will like 
to know when a mode change happened. For userland a signal can be sent. 
This would be useful for someone in X that runs fbset in a Xterm. This 
hoses the X server. It would be nice if the X server would see the signal 
change and adapt to it. Fbset could in theory be used again to change a VC 
size. Yuck!!!! But it is what people want.


