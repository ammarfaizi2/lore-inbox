Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVHASnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVHASnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVHASnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:43:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:49128 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261170AbVHASiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:38:15 -0400
X-Authenticated: #1725425
Date: Mon, 1 Aug 2005 20:37:28 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Message-Id: <20050801203728.2012f058.Ballarin.Marc@gmx.de>
In-Reply-To: <1122908972.18835.153.camel@gaston>
References: <1122908972.18835.153.camel@gaston>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2005 17:09:31 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hi !
> 
> Why are we calling driver suspend routines in these ? This is _not_ a
> good idea ! On various machines, the mecanisms for shutting down are
> quite different from suspend/resume, and current drivers have too many
> bugs to make that safe. I keep getting all sort of reports of machines
> not shutting down anymore.

For example, my Centrino laptop will restart instead of power down with
-mm kernels.

To "fix" this I can either:
- unplug power. Shutdown works when on battery power.
- attach an external USB hard disk => power down always works.
- remove device_suspend(PMSG_SUSPEND) => power down always works.

Marc
