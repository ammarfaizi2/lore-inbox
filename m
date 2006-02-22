Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWBVF52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWBVF52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 00:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWBVF52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 00:57:28 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48137 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751343AbWBVF51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 00:57:27 -0500
Date: Wed, 22 Feb 2006 06:57:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Daniel Barkalow <barkalow@iabervon.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] duplicate #include check for build system
Message-ID: <20060222055719.GA9078@mars.ravnborg.org>
References: <20060221014824.GA19998@MAIL.13thfloor.at> <Pine.LNX.4.64.0602210149190.6773@iabervon.org> <20060221175246.GA9070@mars.ravnborg.org> <20060222001153.GF20204@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222001153.GF20204@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 01:11:53AM +0100, Herbert Poetzl wrote:
> > 
> > Keeping the 'what it needs' part small is a challenge resulting in
> > smaller .h files. But also a good way to keep related things together.
> 
> glad that I stimulated a philosophical discussion
> about the kernel header files and what they should
> include or not ... 
> 
> but the idea was more to give the developers an
> instrument to verify that they are not including
> stuff several times, and that's actually in .h
> and .c files, because it seems that often the same
> header file is included twice in the _same_ file
> 
> anyway, was this a positive or negative reply?

If you can restrict the tool to locate the cases where
a header file is included twice in the same file - then
this is a positive reply.
If you limit the check to the top-level file this is fine,
but I would not be suprised is one or a few .h files
has duplicated includes too.

	Sam
