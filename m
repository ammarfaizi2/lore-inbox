Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUH0WJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUH0WJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUH0WE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:04:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11434 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S267927AbUH0WBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:01:03 -0400
Date: Fri, 27 Aug 2004 15:00:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, jdubois@mc.com
Subject: Re: [patch 1/3]
Message-ID: <20040827220057.GA30360@smtp.west.cox.net>
References: <200408272153.OAA28839@av.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408272153.OAA28839@av.mvista.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 02:53:04PM -0700, trini@kernel.crashing.org wrote:

> #   The following is from Jean-Christophe Dubois <jdubois@mc.com>.
> #   On Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.
> #   However, on cygwin (the other odd place that the kernel is compiled
> #   on) <inttypes.h> doesn't exist.  So we end up with something like
> #   the following.
> #   
> #   Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Arg, I thought I refpatch'ed, but didn't, so they all came out just a
bit wrong.  The descs elsewhere were correct, but this should have been:
On Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.
However, on Cygwin (the other odd place that the kernel is compiled
on) <inttypes.h> doesn't exist.  So we end up testing for __sun__ and
using <inttypes.h> there, and <stdint.h> everywhere else.

-- 
Tom Rini
http://gate.crashing.org/~trini/
