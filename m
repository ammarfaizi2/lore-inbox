Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264807AbTFLK2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbTFLK2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:28:44 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:20957 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264807AbTFLK2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:28:43 -0400
Date: Thu, 12 Jun 2003 12:41:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: Messing up driver model API
Message-ID: <20030612104142.GB139@elf.ucw.cz>
References: <20030611203652.GA599@elf.ucw.cz> <Pine.LNX.4.44.0306111407370.11379-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306111407370.11379-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So you just had to mess it up... Having suspend(device *, state,
> > level) might be bad, but having suspend(device *, state, level) in one
> > piece of code and {suspend,save}(device *, state) is *way* worse. (And
> > I did not see any proposal on l-k. I hope I just missed it).
> 
> Calm down, Pavel. From a technical standpoint, it's a superior
> interface. 

>From a technical standpoint, its now mess with half a kernel using one
interface and second one using another. And you did not bother to mail
the patch to l-k for the review :-(, and then you call me a troll.

> > So are you going to revert it or convert whole driver model to use
> > {suspend,save}(device *, state)?
> 
> Today: neither. I'm going to see how this works, and if it does, then I 
> may convert all the users of struct device_driver to use the same
> model. 

So we are stuck with the mess in 2.6; not good.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
