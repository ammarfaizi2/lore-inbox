Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270974AbTGVSCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270977AbTGVSCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:02:47 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:44298 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270974AbTGVSCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:02:46 -0400
Date: Tue, 22 Jul 2003 19:17:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Samuel Flory <sflory@rackable.com>,
       Charles Lepple <clepple@ghz.cc>, michaelm <admin@www0.org>,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Make menuconfig broken
Message-ID: <20030722191746.A13975@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Simmons <jsimmons@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Samuel Flory <sflory@rackable.com>, Charles Lepple <clepple@ghz.cc>,
	michaelm <admin@www0.org>, linux-kernel@vger.kernel.org,
	vojtech@suse.cz
References: <Pine.LNX.4.44.0307221146120.714-100000@serv> <Pine.LNX.4.44.0307221735160.5483-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307221735160.5483-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Tue, Jul 22, 2003 at 05:47:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 05:47:04PM +0100, James Simmons wrote:
> What about the keyboard being built in. People will still not set that. 

Why not?  With this change they will get asked for keyboard support now.
Now that they actually are asked we can expect them to give the proper
answer.

> The proper solution would be to alter the build system on a default build 
> to scan the .config file for CONFIG_PC_KEYB, CONFIG_MOUSE, CONFIG_BUSMOUSE,
> CONFIG_PSMOUSE etc. Then convert them to what is needed for 2.6.X. The same 
> for framebuffer console stuff. We can scan for CONFIG_FB and if 
> CONFIG_FRAMEBUFFER_CONSOLE is not present set it. We only would need to do 
> this for a default build. 

If you really want that do it a a separate make updateconfig script instead
of bloating make oldconfig.

