Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTLVDF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 22:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLVDF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 22:05:57 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:13779 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264292AbTLVDF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 22:05:56 -0500
Subject: atomic copy_from_user?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1072054100.1742.156.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Dec 2003 19:48:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Surely I'm not the only one wanting such a beast...?

>From some naughty place in the code where might_sleep
would trigger, I'd like to read from user memory.
I'll pretty much assume that mlockall() has been
called. Suppose that "current" is correct as well.
I'd just use a pointer directly, except that:

a. it isn't OK for the 4g/4g feature, s390, or sparc64
b. it causes the "sparse" type checker to complain
c. it will oops or worse if the user screwed up

If the page is swapped out, I want a failed copy.


