Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUDLGXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 02:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUDLGXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 02:23:32 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:13079 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262547AbUDLGXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 02:23:31 -0400
Date: Mon, 12 Apr 2004 08:30:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jon Tidswell <firstname@lastname.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.5 sound arch dependency problem
Message-ID: <20040412063005.GA2128@mars.ravnborg.org>
Mail-Followup-To: Jon Tidswell <firstname@lastname.org>,
	linux-kernel@vger.kernel.org
References: <1081724791.4079cf776e5b0@webmail.bulletproof.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081724791.4079cf776e5b0@webmail.bulletproof.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 09:06:31AM +1000, Jon Tidswell wrote:
> 
> kernel 2.6.5
> 
> Unlike the arch/* directory the makefile for the sound subsystem is not
> robust about missing architecture subdirectories.
> 
> delete arch/{arm,sparc,...} and make mrproper succeeds
This is expected.

> 
> delete sound/{arm,sparc,...} and make mrproper fails
This is expected.

The logic used to select different architectures are different for
the two places, and there is no way to tell kbuild to traverse only
a limited subset of directories in sound/.
So what you ask for is not possible (with todays kbuild).

	Sam
