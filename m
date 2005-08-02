Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVHBSmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVHBSmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 14:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVHBSjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 14:39:49 -0400
Received: from [81.2.110.250] ([81.2.110.250]:28064 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261715AbVHBSi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 14:38:59 -0400
Subject: Re: EOF and ptys
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kern1@rich-paul.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050801235731.GA25477@rich-paul.net>
References: <20050801235731.GA25477@rich-paul.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 02 Aug 2005 20:04:44 +0100
Message-Id: <1123009484.9438.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-01 at 19:57 -0400, kern1@rich-paul.net wrote:
> I notice that when one closes a pty, rather than the master side'd read
> returning 0, it's an EIO.  Seems to be this code, from n_tty.c.
> 	if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {
> 		retval = -EIO;
> 		break;
> 	}
> I'm not an expert, it might be correct, but I thought I should point it
> out.

A pty close is a hangup rather than an end of file. 

Alan

