Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVEaOiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVEaOiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEaOiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:38:14 -0400
Received: from guru.webcon.ca ([216.194.67.26]:61416 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S261689AbVEaOgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:36:14 -0400
Date: Tue, 31 May 2005 10:35:56 -0400 (EDT)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: Jim Crilly <jim@why.dont.jablowme.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: Q: swsusp with S5 instead of S4?
In-Reply-To: <20050530234820.GR28288@voodoo>
Message-ID: <Pine.LNX.4.62.0505311027410.20470@light.int.webcon.net>
References: <Pine.LNX.4.62.0505021701090.14807@light.int.webcon.net>
 <20050530234820.GR28288@voodoo>
Organization: "Webcon, Inc"
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Jim Crilly wrote:

> On 05/02/05 05:13:15PM -0400, Ian E. Morgan wrote:
>> However, some of the ancilary functions, such as LCD brightness, RF kill
>> switch, and volume mute button do not work after resuming.
>
> I had a similar issue in that the power button wouldn't issue any acpi
> events after resuming. The solution was to simply remove the acpi button
> module before suspend and reload it after resume. If you can figure out
> which modules drive the functions that aren't working for you the same
> might be possible.

Unfortunately the LCD/Wifi buttons seem to be managed directly by the
hardware/BIOS. They do not generate input or ACPI events. I have no problem
with the power button or lid generating acpi events.

My best idea at one point was to figure out some way to reset the keyboard
driver, but I don't know how. In theory I could modularize the whole
serio/keyboard system etc, but then I would have no way to unload/reload the
necessary modules without some other form of input, like over a network
connection. I might try that anyways just as an exercise in futility.

> Note that I was using swsusp2 and not the in-kernel swsusp, but I doubt
> that would make a difference.

I tried suspend2 on a lark, but could not get it to work.. always complained
about not being able to allocate enough pages for the image.. which was
clearly bull.. but who knows. Google didn't turn up much.

Thanks for your input, Jim.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
  Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
  imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
     *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
