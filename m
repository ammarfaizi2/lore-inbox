Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTJQRkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTJQRkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:40:52 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:13837 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263568AbTJQRkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:40:51 -0400
Date: Fri, 17 Oct 2003 18:40:47 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "Carlo E. Prelz" <fluido@fluido.as>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
In-Reply-To: <1066387778.661.226.camel@gaston>
Message-ID: <Pine.LNX.4.44.0310171836230.966-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Not sure what's up here. The driver is quite passive regarding
> the mode for other VCs, it sort of expect the fbcon layer do pick up
> the default mode and use it for other consoles. I'm not sure what's
> wrong here.

Using ssty or fbset only changes the resolution on the local VC. I did 
this because often with fbset the user sets the mode to something the 
monitor has a hard time with. If this happened to all the VCs then you 
have to type blind to fix all the VCs. So IMO it is better to risk losing 
one VC then all of them. You can change the size of all VCs by calling the 
vt ioctl call VT_RESIZE
 
> In a more general way, I really lack the ability to change the console
> size with fbset like I could do with 2.4. I don't know if James revived
> that feature in his latest patches though. The stty thing isn't very
> reliable imho. Especially on monitors that don't like the standard
> modedb.

Not in this set of patches but with client support coming soon we will be 
able to change the VCs resolution via fbset again.


