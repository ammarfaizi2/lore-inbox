Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbTEOCba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTEOCba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:31:30 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:63504 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263727AbTEOCba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:31:30 -0400
Date: Thu, 15 May 2003 04:44:17 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: James Simmons <jsimmons@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Message-ID: <20030515024417.GA29602@win.tue.nl>
References: <20030514120950.GA302@elf.ucw.cz> <Pine.LNX.4.44.0305142248040.13403-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305142248040.13403-100000@phoenix.infradead.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 11:19:59PM +0100, James Simmons wrote:

> P.S
>     KDGKBDTYPE.   (Wow, I can't believe we still have this. It should die)

It is rather useless for determining keyboard proterties, yes.
On the other hand, quite a few utilities use it in code like

static int
is_a_console(int fd) {
    char arg;

    arg = 0;
    return (ioctl(fd, KDGKBTYPE, &arg) == 0
            && ((arg == KB_101) || (arg == KB_84)));
}

Andries

