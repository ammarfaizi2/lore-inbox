Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262909AbSJRIzP>; Fri, 18 Oct 2002 04:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262914AbSJRIzP>; Fri, 18 Oct 2002 04:55:15 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:20372 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262909AbSJRIzP>;
	Fri, 18 Oct 2002 04:55:15 -0400
Date: Fri, 18 Oct 2002 04:00:37 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Christopher Hoover <ch@murgatroid.com>
cc: linux-kernel@vger.kernel.org, <vojtech@suse.cz>,
       Arnaud Gomes-do-Vale <arnaud@carrosse.frmug.org>
Subject: Re: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse
In-Reply-To: <20021017231953.A17985@heavens.murgatroid.com>
Message-ID: <Pine.LNX.4.44.0210180354140.19699-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, Christopher Hoover wrote:

> The wheel on my Logitech mouse doesn't work under the input layer.
> The mouse was originally recognized as:
> 
>   input: PS2++ Logitech Mouse on isa0060/serio1
> 
> In this mode, the driver also emits (just once?):
> 
>   psmouse.c: Received PS2++ packet #0, but don't know how to handle.
> 
> 
> The following patch simply swaps the order of detection of Logitech PS
> 2++ and Intellimouse protocols.  Now my mouse is recognized as:
> 
>   input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> 
> And the wheel works properly in this mode.

I am also carrying a problem report from Arnaud Gomes-do-Vale with this 
exact problem.  If this is deemed a proper fix it would probably close 
the other outstanding report.


