Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271412AbTGQLFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271422AbTGQLFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:05:07 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:29455 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271412AbTGQLFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:05:02 -0400
Date: Thu, 17 Jul 2003 13:19:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030717131955.D2302@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717122600.A2302@pclin040.win.tue.nl> <bf5uqb$3ei$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <bf5uqb$3ei$1@news.cistron.nl>; from miquels@cistron.nl on Thu, Jul 17, 2003 at 10:46:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 10:46:35AM +0000, Miquel van Smoorenburg wrote:

> The filesystem driver itself must convert from native rdev to linux 32:32.

Look at the mknod utility.
The user types major,minor.
The system call uses dev_t.
This means that user space needs to be able to combine
major,minor into a dev_t.

It is not a good idea to require of mknod that it knows
about the filesystem the node is going to be created on.

Andries


[In other words: we invent something, and what we invent is
encoded in <sys/sysmacros.h>. It cannot depend on fs type.]


