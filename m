Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUJOQUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUJOQUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUJOQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:20:35 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:16575 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S268127AbUJOQSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:18:38 -0400
Subject: Re: janitoring printk with no KERN_ constants, kill all defaults?
From: Daniele Pizzoni <auouo@tin.it>
To: Dave Jones <davej@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041015154658.GD23638@redhat.com>
References: <1097855099.3004.64.camel@pdp11.tsho.org>
	 <20041015154658.GD23638@redhat.com>
Content-Type: text/plain
Message-Id: <1097860808.3004.80.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 19:20:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ven, 2004-10-15 at 17:46, Dave Jones wrote:
> On Fri, Oct 15, 2004 at 05:44:59PM +0200, Daniele Pizzoni wrote:
> 
>  > I ask, what rationale there is behind checking all printks to include
>  > the "appropriate" constant? Should then we make printk fail when called
>  > without KERN_ constant? Or can I force with a sed script all defaulted
>  > printk to KERN_WARNING?
> 
> No. Consider this..
> 
> 	printk (KERN_INFO "blah blah ");
> 	if (foo)
> 		printk ("%s", stringptr);
> 	else
> 		printk ("%d", number);
> 	printk ("\n");
> 
> There's nothing wrong with any of those printk's, so you
> cannot do the checks you mention above.

Let me understand... You mean that we should check printk constants for
_consistency_ in their context (that is: for buggish printk code). So
printk without KERN_* constant are not an issue (and the janitors TODO
list entry is a bit puzzling)?

Thanks for helping
Daniele


