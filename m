Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271834AbTGYAHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271835AbTGYAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:07:52 -0400
Received: from quechua.inka.de ([193.197.184.2]:17861 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S271834AbTGYAHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:07:46 -0400
From: Bernd Eckenfels <ecki-lkm@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
In-Reply-To: <200307250156.47108.fredrik@dolda2000.cjb.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19fqMF-0007me-00@calista.inka.de>
Date: Fri, 25 Jul 2003 02:22:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200307250156.47108.fredrik@dolda2000.cjb.net> you wrote:
> On the other hand, I cannot imagine that noone would have thought of it. What 
> is the reason for this? Is there another interface that I should use instead 
> of /proc/net/dev to gather byte statistics for interfaces?

it is for performance reasons. You can

a) collect your numbers more often and asume wrap/reboot  if numbers
decrease
b) use iptables counters instead

BTW: it is a very often discussed topic, personally (as net tools
maintainer) I would love to see 64bit counters here, but this still means
you have to sample often enough, so you do not lose numbers on crash.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
