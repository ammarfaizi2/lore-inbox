Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbTDKRzp (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbTDKRzp (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:55:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:59266 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261334AbTDKRzn (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:55:43 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Apr 2003 20:07:24 +0200 (MEST)
Message-Id: <UTC200304111807.h3BI7Or07403.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, James.Bottomley@steeleye.com
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       pbadari@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From James.Bottomley@SteelEye.com  Fri Apr 11 16:33:37 2003

    On Fri, 2003-04-11 at 06:42, Andries.Brouwer@cwi.nl wrote:
    >     Here is my problem..
    > 
    > OK, I see what you mean. I agree.

    Could you elaborate on the reason you want to keep the minor space
    compact?

That is not necessarily what I want.
Indeed, I see as one of the possible uses of a large dev_t
a hash of a proper name.

It is just that Badari and I were talking about the numbering scheme
index = next_index++ and he pointed out that the current system
has a certain weak number preservation guarantee that this
index = next_index++ does not have. True.

It is Roman who wanted to keep the number space compact.

It is me who wants compatibility as far as 8+8 device numbers are
concerned, while I can see lots of ways to use new number space.

(You need not worry that I worry about preservation of numbering
after rmmod. I am not interested. But in case anybody is, there
is a numbering solution that achieves that, too.)

The whole conversation came because there is an array in sd.c
that must go, or must be limited to the size needed for compatibility.

Andries
