Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVDVWSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVDVWSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 18:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDVWSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 18:18:35 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:49108 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261207AbVDVWSb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 18:18:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZI5FCcgA/mHmZx/6hxwmXMbEojVA5X8/6NORuBQL4ZD+gDO7KIuiCeTUivhrXBhCT/NX/ZBeVxm/K2wW6U7DIgeqaPHdPG630nYE0+o2+8EJRNQNdaCXU1pwbiHF6QE7QDtEwU42rcazvkTbKT5/P03iml2PIPJ85XfKzjYdFO0=
Message-ID: <40f323d005042215184714acda@mail.gmail.com>
Date: Sat, 23 Apr 2005 00:18:30 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Question: ioctl functions
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like (i havent checked all the tree) that every function that
is registered as ioctl (or
read_ioctl or fb_ioctl or ...) have an argument "unsigned long arg",
then each function is using
it like this:

void __user *argp = (void __user *)arg;

I am wondering why the argument isn't from type "void __user *".

Thanks,

Benoit
