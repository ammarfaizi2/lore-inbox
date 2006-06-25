Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWFYTho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWFYTho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWFYTho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:37:44 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:2287 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932155AbWFYTho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:37:44 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 25 Jun 2006 21:35:24 +0200
To: schilling@fokus.fraunhofer.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read atip wiith cdrecord
Message-ID: <449EE57C.nailFJ11EKZ3@burner>
References: <449E6B43.nail9A11I1BV@burner>
 <20060625040642.f37646ba.akpm@osdl.org> <449E777C.nail9X1595M9@burner>
In-Reply-To: <449E777C.nail9X1595M9@burner>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> I am not sure if the log from the OP includes all information.
>
> I've seen already messages like this:
>
> cdrecord: Input/output error. Cannot set SG_SET_TIMEOUT.
>
> This should be something that I would never to expect to happen.
>
> If the OP does not see a similar message, it seems that the call is
> accepted but later ignored. I have no idea why this happens.

Let me add some notes:

Some drives do not support (or correctly support) the 'read buffer' command.
As I don't have all drives, I cannot tell how the drive from the OP behaves on
Solaris. All drives I've seen so far return an error on Solaris - not a timeout,
so it is not clear, whether the hang on Linux would result in a timeout on Solaris.

It may be that the /dev/hd* interface ignores timeouts, but it may also be that
the bus situation did cause a kernel hang. As my experience shows that all 
drives behave always the same, it should be simple to trace the problem for the 
owner of a drive.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
