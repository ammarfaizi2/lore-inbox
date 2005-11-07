Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVKGGho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVKGGho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVKGGho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:37:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2314 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964799AbVKGGhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:37:43 -0500
Date: Mon, 7 Nov 2005 07:23:25 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, bonding-devel@lists.sourceforge.net,
       ctindel@users.sourceforge.net, fubar@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH] fix ifenslave to not fail on lack of IP information
Message-ID: <20051107062325.GE11266@alpha.home.local>
References: <20051104165434.GB17181@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104165434.GB17181@hmsreliant.homelinux.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 04, 2005 at 11:54:34AM -0500, Neil Horman wrote:
> The current version of ifenslave fails to attach slave interfaces to a bond if
> the masters doesn't have appropriate IP information.  While its common for
> bonded interface to have IP information its not required (bond as part of a
> bridge for instance).  This patch modifies ifenslave to not fail if IP
> information is not available in the master at the time of enslaving.
> 
> Regards
> Neil
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> 
>  ifenslave.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/Documentation/networking/ifenslave.c b/Documentation/networking/ifenslave.c
> --- a/Documentation/networking/ifenslave.c
> +++ b/Documentation/networking/ifenslave.c
(...)

I find it annoying that ifenslave is still hosted by the kernel. I made
this mistake years ago because it was not hosted anywhere and I needed
to make changes available somewhere, but it should move to somewhere
else, either as a standalone package on sf.net, or added to an existing
package such as ifconfig, or better merged with it. I even think that
if ifconfig included all ifenslave, vconfig, ethtool and brctl functions,
it wouldn't be abandonned as it is now, but this is another problem.

Regards,
Willy

