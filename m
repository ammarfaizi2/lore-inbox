Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTI3Xeb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTI3Xea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:34:30 -0400
Received: from opus.cs.columbia.edu ([128.59.20.100]:20958 "EHLO
	opus.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S261787AbTI3Xe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:34:28 -0400
Subject: compartmentalizing INADDR_ANY
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064964305.14962.13.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 30 Sep 2003 19:25:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to work on a project to compartmentalize INADDR_ANY so that
an application doesn't have to be modified, but can run in an
environment where it has less access to machine resources.  It's mostly
proof of concept/researchy so solution can be ugly for now, but what
would I have to do to effectively bind a single socket to multiple
adapters, so that one can mimic INADDR_ANY behavior?

I'm not anywhere comfortable with the networking code yet, but in
looking through the code briefly, it seems like there are these "hash
buckets" that get searched through to see if/what socket is bound to a
particular port.  Is it as simple as mucking with those internals and
having multiple of those buckets point to the same socket?

has anyone done anything like this b4, or even thought about it?

oh, and I'd appreciate being CC'd as my l-k backlog is back to over 10k
message :(

thanks,

shaya

