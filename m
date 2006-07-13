Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWGMPbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWGMPbH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWGMPbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:31:06 -0400
Received: from gw.goop.org ([64.81.55.164]:25558 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030231AbWGMPbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:31:05 -0400
Message-ID: <44B66740.2040706@goop.org>
Date: Thu, 13 Jul 2006 08:31:12 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: George Nychis <gnychis@cmu.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <44B5CE77.9010103@cmu.edu> <44B604C8.90607@goop.org> <44B64F57.4060407@cmu.edu>
In-Reply-To: <44B64F57.4060407@cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Nychis wrote:
> I am not seeing any problems at all, though I am not seeing anything
> happen :)
>
> If I Fn+suspend... nothing happens ... if i Fn+hibernate ... nothing happens
>
> What patches did you use?
Sounds like your first step is to set up acpi.  What distro are you 
using?  What happens if you do "echo -n mem > /sys/power/state"?

The patches you need are to make the ahci disk interface resume 
properly.  There's a series of 6 patches from Forrest Zhao which he 
posted to the linux-ide list, and they apply cleanly to 2.6.18-rc1-mm1.

    J

