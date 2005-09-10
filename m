Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbVIJAWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVIJAWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbVIJAWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:22:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:478 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030404AbVIJAWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:22:32 -0400
Date: Fri, 9 Sep 2005 17:22:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: gregkh@suse.de, davej@codemonkey.org.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
In-Reply-To: <20050909163634.21afe4ca.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509091644050.30958@g5.osdl.org>
References: <20050909220758.GA29746@kroah.com> <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org>
 <20050909225421.GA31433@suse.de> <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org>
 <20050909163634.21afe4ca.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Sep 2005, Andrew Morton wrote:
> 
> If something like a PCI power management function fails then it will likely
> cause suspend or resume to malfunction, and we have a lot of such problems.

No, for several reasons.

First off, some of those functions can't fail in normal usage. Thus 
telling people that they have to check the return code is insane.

Secondly, at least some of the suspend failures have historically been
because drivers returned errors for no good reason. Adding yet another 
broken reason to return error is not going to help.

		Linus
