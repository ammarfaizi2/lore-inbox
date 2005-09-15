Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbVIOQdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbVIOQdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030523AbVIOQdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:33:19 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:13971 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030520AbVIOQdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:33:18 -0400
Date: Thu, 15 Sep 2005 18:33:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Budde, Marco" <budde@telos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to find "Unresolved Symbols"
Message-ID: <20050915163324.GA7734@mars.ravnborg.org>
References: <809C13DD6142E74ABE20C65B11A2439809C4CA@www.telos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4CA@www.telos.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 02:47:02PM +0200, Budde, Marco wrote:
> Hi,
> 
> I am working on a larger kernel module.
> This module will be based on a lot of
> portable code, for which I have to implement
> the OS depended code.
> 
> At the moment I can compile the complete
> code into a module. Some of OS depended
> code is still missing, but I do not get
> any warnings from kbuild.
> 
> When I try to load the module, I can a really
> strange error message:
> 
>  insmod: error inserting 'foo.o': -795847932 Function not implemented
> 
> What does that mean? How can I get a list
> of missing symbols?

How do you compile the module?
I you use:
make dir/file.ko
then kbuild will warn you about undefined symbols.
Here I assume you only use standard methods in your kbuild file, and do
not play funny tricks with vermagic etc.

	Sam
