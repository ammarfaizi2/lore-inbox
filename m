Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262512AbSJKPfF>; Fri, 11 Oct 2002 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262522AbSJKPfF>; Fri, 11 Oct 2002 11:35:05 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:22930
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262512AbSJKPfE>; Fri, 11 Oct 2002 11:35:04 -0400
Date: Fri, 11 Oct 2002 11:21:01 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, <pavel@ucw.cz>
Subject: Re: make idedisk_suspend()/idedisk_resume() conditional on
 CONFIG_SOFTWARE_SUSPEND
In-Reply-To: <20021011141218.GP12432@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0210111101530.8784-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, William Lee Irwin III wrote:

> ide-disk.c gets the following warning:
> 
> drivers/ide/ide-disk.c:1614: warning: `idedisk_suspend' defined but not used
> drivers/ide/ide-disk.c:1651: warning: `idedisk_resume' defined but not used

Hi Pavel,
	shouldn't this kinda thing be handled by the driver model layer? 
Ditto for the device walk and suspend in suspend.c. Also what do you 
think of adding hooks to driver model tree so that we can add additional 
handlers for things like this with the driver model doing the final 
suspend as specified in the driver. 

	Zwane
-- 
function.linuxpower.ca


