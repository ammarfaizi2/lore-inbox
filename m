Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSGZPyN>; Fri, 26 Jul 2002 11:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317860AbSGZPyN>; Fri, 26 Jul 2002 11:54:13 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35576 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317859AbSGZPyM>; Fri, 26 Jul 2002 11:54:12 -0400
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
In-Reply-To: <26333.1027692205@redhat.com>
References: <1027695029.13428.45.camel@irongate.swansea.linux.org.uk> 
	<1027680964.13428.37.camel@irongate.swansea.linux.org.uk>
	<1027679991.13428.24.camel@irongate.swansea.linux.org.uk>
	<3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com>
	<9309.1027608767@redhat.com> <9143.1027671559@redhat.com>
	<12015.1027676388@redhat.com> <12441.1027677534@redhat.com>  
	<26333.1027692205@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 18:11:25 +0100
Message-Id: <1027703485.13429.53.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 15:03, David Woodhouse wrote:
> Good point -- so if a writer encounters a locked page when it's trying to 
> unmap them all, it needs to still allow other pages to be mapped in while 
> it waits for the original page to become unlocked. That avoids the deadlock 
> -- but leaves us with the potential for livelock, with the writer being 
> starved by too many other things locking down the pages in question.
> 
> I suspect the number of pages getting locked will be sufficiently small 
> that the deadlock does not occur. 

Well for a starter lets try user writing a block to flash which needs an
erase from a block which happens to be not yet paged in and so still on
the flash you are writing to.


