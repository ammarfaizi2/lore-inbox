Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWCFUpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWCFUpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWCFUpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:45:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:780 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751583AbWCFUpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:45:35 -0500
Date: Mon, 6 Mar 2006 21:45:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Paul D. Smith" <psmith@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change kbuild to not rely on incorrect GNU make behavior
Message-ID: <20060306204517.GA29092@mars.ravnborg.org>
References: <E1FG1UQ-00045B-5P@fencepost.gnu.org> <20060305231312.GA25673@mars.ravnborg.org> <17419.34083.172540.639486@lemming.engeast.baynetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17419.34083.172540.639486@lemming.engeast.baynetworks.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 07:41:07PM -0500, Paul D. Smith wrote:
> %% Sam Ravnborg <sam@ravnborg.org> writes:
> 
>   sr> Thanks Paul.
>   sr> Adapted to -rc4 and applied to my kbuild tree which I have pushed out.
>   sr> For reference I added the applied patch below.
> 
> OK.  Note that this:
> 
>   sr> -.PHONY: tar%pkg
>   sr> +PHONY += tar%pkg
>   sr>  tar%pkg:
> 
> won't do what you expect.  tar%pkg is a pattern rule, but .PHONY doesn't
> take patterns so you're declaring the actual file named literally
> 'tar%pkg' to be phony.

So I can just let all relevant target rules include FORCE as
prerequisite and skip the PHONY part all together.
Thats what FORCE is there for anyway so this is just normal kbuild style
anyway.

	Sam
