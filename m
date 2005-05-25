Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVEYRr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVEYRr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVEYRr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:47:59 -0400
Received: from jade.aracnet.com ([216.99.193.136]:50403 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261513AbVEYRr6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:47:58 -0400
From: van <van.wanless@eqware.net>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 3.3 (2110) - Licensed Version
Date: Wed, 25 May 2005 10:47:55 -0700
Message-ID: <2005525104755.652038@Oz>
Subject: Re: File I/O from within a drive
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your assumption that the driver should parse the media file structure
> is probably wrong. You should rather do as much as possible in a user
> space library. Pass a file name to a library call and have that
> work with all the complex parts of the file format, then define an
> ioctl interface for the driver on a relatively low level.

I think this is probably the bit of insight I was looking for; when it looks what what you need to do is wrong, you probably don't need to do that.

In fact, right now I am implementing a simple write() interface as a starting point.  Later on I will be wanting to used mmap()ed buffers anyway, and at that point the application (or some app-level library) will *absolutely* have to be able to parse frames out of the media file.

Thanks, all.
 
--Van Wanless
EQware Engineering, Inc.
van.wanless@eqware.net
 

