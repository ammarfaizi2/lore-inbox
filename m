Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUIFC7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUIFC7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 22:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUIFC7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 22:59:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:36587 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264213AbUIFC7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:59:08 -0400
Date: Sun, 5 Sep 2004 11:00:32 -0400
From: Greg KH <greg@kroah.com>
To: John Lenz <lenz@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-ID: <20040905150032.GF12701@kroah.com>
References: <20040617223517.59a56c7e.zap@homelink.ru> <20040725215917.GA7279@hydra.mshome.net> <20040813232739.GB5063@kroah.com> <1093056693l.30570l.0l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093056693l.30570l.0l@hydra>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 02:51:33AM +0000, John Lenz wrote:
> 
> Here.  A few notes on the implementation.  I have a global lock protecting
> all match operations because otherwise we get a dining philosophers problem.
> (Say the same class is in two class_match structures, class1 in the first 
> one and class2 in the second...)

You also have some duplicated code in one function, which implies that
you didn't test this patch (it's in the updated patch you sent me too) :)

> The bigger question of how should we be linking these together in the first 
> place?

I thought you only wanted the ability to actually find the different
class devices.  Then the code would take it from there.  Not this
complex driver core linking logic that you implemented.

> Instead of using this class_match stuff, we could use class_interface.

Exactly.  Why don't you all use that instead?

thanks,

greg k-h
