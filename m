Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263747AbTDITb6 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbTDITb5 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:31:57 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:51932 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263747AbTDITb5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 15:31:57 -0400
Date: Wed, 9 Apr 2003 21:48:54 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod support
Message-ID: <20030409194854.GA4449@brodo.de>
References: <20030408205623.GA5253@brodo.de> <20030408212059.GA5358@gtf.org> <20030408213403.GA5250@brodo.de> <3E9354D3.8090805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9354D3.8090805@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 07:01:39PM -0400, Jeff Garzik wrote:
> >As strings can't be passed to userspace in file2alias.c, I've chosen the
> >crc32 value of the string as the matching identifier for the userspace
> >hotplug script.
> 
> This sounds like a problem to be solved, not worked around...  the 
> source should have the strings presented directly, and I'm sure a 
> creative and smart person such as yourself can conceive of at least 
> one... ;-)

OK, there might be a way to do this (and yes, I can think of one...).
However, I doubt it makes sense: using strings in depmod.c and in the
hotplug utilities is even worse than in file2alias.c. For example, 
whitespace is used as delimitier for the values being parsed in hotplug
scripts. So I think the better (as simpler and thus more difficult to break)
approach is using crc32.

	Dominik
