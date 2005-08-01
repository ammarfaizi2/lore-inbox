Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVHAX5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVHAX5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVHAX5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:57:36 -0400
Received: from rrcs-24-173-162-234.se.biz.rr.com ([24.173.162.234]:52619 "EHLO
	rich-paul.net") by vger.kernel.org with ESMTP id S261367AbVHAX5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:57:32 -0400
Date: Mon, 1 Aug 2005 19:57:31 -0400
From: kern1@rich-paul.net
To: linux-kernel@vger.kernel.org
Subject: EOF and ptys
Message-ID: <20050801235731.GA25477@rich-paul.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that when one closes a pty, rather than the master side'd read
returning 0, it's an EIO.  Seems to be this code, from n_tty.c.
	if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {
		retval = -EIO;
		break;
	}
I'm not an expert, it might be correct, but I thought I should point it
out.

Regards,
Rich Paul

-- 
Never let 'em tell you the drug war is a total failure.  It's preventing sick
people from getting enough pain medication, isn't it?

http://radical-centrist.blogspot.com
