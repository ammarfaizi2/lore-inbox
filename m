Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTKTUtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 15:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTKTUtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 15:49:01 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:28685 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S262034AbTKTUs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 15:48:59 -0500
Message-ID: <3FBD27A0.50803@techsource.com>
Date: Thu, 20 Nov 2003 15:44:16 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby>	<20031120172143.GA7390@deneb.enyo.de>  <03112013081700.27566@tabby> <1069357453.26642.93.camel@lotte.street-vision.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Justin Cormack wrote:
> On Thu, 2003-11-20 at 19:08, Jesse Pollard wrote:

> If you really want a filesystem that supports efficient copying you
> probably want it to have the equivalent of COW blocks, so that a copy
> just sets up a few pointers, and the copy only happens when the original
> or copied files are changed.
> 
> But basically you wont get a syscall until you have a filesystem with
> semantics that only maps onto this sort of operation.


This could be a problem if COW causes you to run out of space when 
writing to the file.

This could also be a benefit if, for whatever reason, you have lots of 
copies of the same file that you never change.  But that sounds somewhat 
pointless to me.

