Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTFSXTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTFSXTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:19:05 -0400
Received: from almesberger.net ([63.105.73.239]:24840 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261852AbTFSXTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:19:04 -0400
Date: Thu, 19 Jun 2003 20:32:30 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030619203230.E6248@almesberger.net>
References: <3EE8D038.7090600@mvista.com> <bcd3rj$1it$1@old-penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd3rj$1it$1@old-penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jun 13, 2003 at 06:06:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [ Event demons ] encourage doing everything in one program,
> keeping state in private memory, depending on ordering, and just
> generally do bad things. 

Well, the ordering bit is the hairy part. As long as it doesn't
matter if an event gets lost every once in a while, and in which
order they get processed, things are fine as they are.

But then it scares me to see people start to try to design some
general serialization mechanism on top of /sbin/hotplug

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
