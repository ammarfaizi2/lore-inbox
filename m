Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285556AbSACVtA>; Thu, 3 Jan 2002 16:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSACVsv>; Thu, 3 Jan 2002 16:48:51 -0500
Received: from vena.lwn.net ([206.168.112.25]:27146 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S285556AbSACVsk>;
	Thu, 3 Jan 2002 16:48:40 -0500
Message-ID: <20020103214839.9953.qmail@eklektix.com>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The CURRENT macro 
From: corbet@lwn.net (Jonathan Corbet)
In-Reply-To: Your message of "Thu, 03 Jan 2002 16:34:55 EST."
             <20020103213455.34699.qmail@web14911.mail.yahoo.com> 
Date: Thu, 03 Jan 2002 14:48:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In Alessandro Rubini's book Linux Device Driver(Second
> Edition), Chatper 12

Alessandro and...um...some other guy...:)

> he said that "By accessing the
> fields in the request structure, usually by way of
> CURRENT" and "CURRENT is just a pointer into
> blk_dev[MAJOR_NR].request_queue". I know CURRENT is
> just a macro. Where can I find the definition of this
> macro?

A little grepping in the source would give you the answer there.  It's in
.../include/linux/blk.h.  

> I just don't know how to get the struct request from
> the request_queue(a request_queue_t struct). CURRENT
> points to which field in the
> blk_dev[MAJOR_NR].request_queue? Thank you very much.

CURRENT is one way.  There's also functions like blkdev_entry_next_request
(also described in that chapter) that will pull a request off the queue for
you, if that's what you need.

Note that all this stuff has changed quite a bit in 2.5.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
