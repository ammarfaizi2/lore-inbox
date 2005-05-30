Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVEaAFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVEaAFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVEaADf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:03:35 -0400
Received: from atpro.com ([12.161.0.3]:25351 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261647AbVE3XyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:54:19 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Mon, 30 May 2005 19:48:20 -0400
To: "Ian E. Morgan" <imorgan@webcon.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: Q: swsusp with S5 instead of S4?
Message-ID: <20050530234820.GR28288@voodoo>
Mail-Followup-To: "Ian E. Morgan" <imorgan@webcon.ca>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	pavel@suse.cz
References: <Pine.LNX.4.62.0505021701090.14807@light.int.webcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505021701090.14807@light.int.webcon.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/05 05:13:15PM -0400, Ian E. Morgan wrote:
> I'm using swsusp on my new HP dv1000 notebook. In general most everything
> works just fine, in terms of general computing anyways, after resume.
> 
> However, some of the ancilary functions, such as LCD brightness, RF kill
> switch, and volume mute button do not work after resuming.

I had a similar issue in that the power button wouldn't issue any acpi
events after resuming. This was annoying because I could hit the power key
to suspend only once. The solution was to simply remove the acpi button
module before suspend and reload it after resume, if you can figure out
which modules drive the functions that aren't working for you the same
might be possible.

Note that I was using swsusp2 and not the in-kernel swsusp, but I doubt
that would make a difference.

> 
> Regards,
> Ian Morgan

Jim.
