Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWADXi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWADXi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWADXi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:38:57 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:61646 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750718AbWADXi4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:38:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jvh5AR0iGQVjwTN5je8kJFqNmiiFaV668SRJKTWQgOH9Dva/9YUsrjowr29vU4VM3dj0CJzd2OOqvZ9EPk/FSdVyavJGcOytxKONFIjR5YBruvBqq16iIoDtFjdrv+Zwnx2M9nMcfH+/FHnQTS44zgVPqN8LgSjNXMLDHxAa3wU=
Message-ID: <4807377b0601041538t98275acn54a36374a42346ab@mail.gmail.com>
Date: Wed, 4 Jan 2006 15:38:55 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: c-otto@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Intel e1000 fails after RAM upgrade
In-Reply-To: <20060102121752.GA29275@carsten-otto.halifax.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de>
	 <20060102121752.GA29275@carsten-otto.halifax.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/06, Carsten Otto <c-otto@gmx.de> wrote:
> On Mon, Dec 19, 2005 at 08:54:58PM +0100, Carsten Otto wrote:
> > e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>
> Is there anything I can do to make this work and/or you have more fun
> and luck fixing this? I could provide plenty of debugging information,
> just tell me what you need. Unfortunately I am unable to solve the
> problem myself.
>
> Short summary:
> Every e1000 card I tried (Desktop MT) produces above error in my
> computer and works in other PCs. Memory/BIOS/Kernel-version do not
> change this. Either the kernel is flawed in several versions or my system
> (Gentoo) does some ugly things to the driver (I doubt that). Changing some
> values with ethtool does not help.

I'm not sure it's e1000, is there any chance you can try a different
network adapter (like not e1000 based)?  with the ethtool diags error
there is something corrupting memory in your system or on your pci bus
(most likely)

My best recommendation is to check to make sure there aren't any bios
updates for your system, make sure you aren't running overclocked on
the pci bus, try different slots, try a different network adapter. 
Maybe you can try memtest86 overnight?

Honestly right now it doesn't sound like a network problem, but a
system problem.

Jesse
