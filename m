Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTDNUzS (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTDNUzS (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:55:18 -0400
Received: from uswest-dsl-142-38.cortland.com ([209.162.142.38]:29704 "HELO
	warez.scriptkiddie.org") by vger.kernel.org with SMTP
	id S263742AbTDNUzR (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:55:17 -0400
Date: Mon, 14 Apr 2003 14:07:05 -0700 (PDT)
From: Lamont Granquist <lamont@scriptkiddie.org>
X-X-Sender: lamont@uswest-dsl-142-38.cortland.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel Sockets Programming:  closing sockets?
In-Reply-To: <1050350202.26521.5.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <20030414140119.D57110-100000@uswest-dsl-142-38.cortland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got some code I'm using which is calling sock_alloc(), sock_map_fd(),
socket->ops->connect() and then I'm trying to destroy it with
sock_release().  I'm leaving around file descriptors, so its pretty
obvious that I need to do more than sock_release() but I'm having trouble
figuring out exactly what I need to do.  I'm thinking about adding a call
to sys_close() on the file descriptor I get back from sock_map_fd(), but I
haven't implemented that yet.  Can anyone offer some insight, or
preferably some example code I could look at?

