Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUAGVLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUAGVLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:11:41 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:50905 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265659AbUAGVLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:11:39 -0500
Date: Wed, 7 Jan 2004 13:11:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Message-ID: <20040107211134.GR1882@matchmail.com>
Mail-Followup-To: Mike Waychison <Michael.Waychison@Sun.COM>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it> <m3ad50tmlq.fsf@averell.firstfloor.org> <3FFC46EB.9050201@zytor.com> <3FFC7469.3050700@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFC7469.3050700@sun.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 04:04:41PM -0500, Mike Waychison wrote:
> H. Peter Anvin wrote:
> 
> >>Also when /home or other important fs are mounted via autofs there is
> >>not much practical difference between a hung kernel and a hung
> >>daemon. You have to reboot the system anyways.
> >
> >
> >a) Guess which one is easier to debug?
> 
> When they may both equally hang your machine, neither.

Let's see.

If it's in userspace, then setup your debug area in an area your system
doesn't depend on, and wham, the hang won't affect the entire system anymore.

Also, if you have /home automounted then it only affects the users on /home,
and root's $home should be /home...

Though, you can debug in-kernel code with UML...
