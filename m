Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275794AbTHOImJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275795AbTHOImJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:42:09 -0400
Received: from AMarseille-201-1-4-67.w217-128.abo.wanadoo.fr ([217.128.74.67]:14119
	"EHLO gaston") by vger.kernel.org with ESMTP id S275794AbTHOImH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:42:07 -0400
Subject: Re: FBDEV updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0308142150390.15200-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0308142150390.15200-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060936833.13534.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 10:40:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 22:52, James Simmons wrote:
> > what is the current state of PM in fb drivers?
> 
> Experinmental patch from Ben is in the works.

That patch actually works here and I'm more/less waiting for it
to be merged so I can send you the driver updates based on it.
(It's becoming rather urgent. My pending PowerMac updates that
port things to the new model are causing PM to break on PowerBook
laptops now because fbdev has incorrect PM and the "old style" thing
isn't properly ordered).

The only thing you may probably want to fix (because you know
that code better than I do) are:

 - the "resume" callback in fbcon where I currently just refresh
the foreground console, while you may actually want to refresh the
one on this fb since I suppose that with mutiple heads, we may have
consoles on more than one head ?

 - the suspend callback where you probably want to disable the
cursor timer

Ben. 
