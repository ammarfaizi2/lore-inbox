Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbTHCTLR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbTHCTLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:11:16 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:53253 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S268737AbTHCTLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:11:15 -0400
Date: Sun, 3 Aug 2003 21:11:02 +0200
From: Willy Tarreau <willy@w.ods.org>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803191102.GA29616@alpha.home.local>
References: <20030803180950.GA11575@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803180950.GA11575@outpost.ds9a.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 08:09:50PM +0200, bert hubert wrote:
 
> It blocks attempts by rootkits, such as devik's SucKIT, to hide themselves.
> 
> It is not a final solution but it raises the bar a lot. Please apply.
> 
> By default, nothing is changed, but I'd turn this feature on on servers
> without X. Patch:

Why not make this change dynamic instead ? eg : your system boots unlocked,
and definitely locks /dev/{,k}mem once you do something such as

  echo foo > /proc/path_to_magic_entry

So the same config can be used with kernel with and without X, it's just a
matter of runtime configuration. It could even be a sysctl, as long as there's
no way to unset it.

Regards,
Willy

