Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTD2UcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 16:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTD2UcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 16:32:25 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:37749 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261698AbTD2UcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 16:32:23 -0400
Date: Tue, 29 Apr 2003 16:40:37 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Swap Compression
In-reply-to: <3EAEDB7C.9080101@techsource.com>
To: linux-kernel@vger.kernel.org
Message-id: <200304291640370180.04AB5D50@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <3EAEDB7C.9080101@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*********** REPLY SEPARATOR ***********

On 4/29/2003 at 3:39 PM Timothy Miller wrote:

>
>
>Con Kolivas wrote:
>
>On Tue, 29 Apr 2003 07:35, Timothy Miller wrote:
>
>The work that Rodrigo De Castro did on compressed caching
>(linuxcompressed.sf.net) included a minilzo algorithm which I used by
>default
>in the -ck patch addon as it performed the best for all the reasons you
>mention. Why not look at that lzo code for adoption.
>Some time before rmoser started HIS discussion on compressed swap, I
>started a discussion on the same topic.  Out of that discussion came
>mention of an existing project which did EXACTLY what I was proposing.
>That made me happy.  For some reason rmoser wants to start from scratch.
>He can do that if he wants.  I had only hoped that my earlier mention of
>it would spark interest in taking the existing implementation and adding
>it to the mainline kernel, after some incompatbilities were dealt with.
>Unfortunately, I don't have the time to engage directly in that particular
>aspect the kernel development
>

I want to start from scratch because I am trying a different angle, and I don't understand
fully current projects on it.  I am not trying to discredit anyone.  In fact, I would hope that
the existing implimentation (different as it is) would manage to get itself in as well.
Remember, modularity is all about options. Options aren't just "Do you want this or
that?", but also "How do you want this or that done?"  Plus, I am not compressing the
page cache, assuming I understand what this means.  AFAIK (from others' help), the
page cache is a cached copy of pages that have gone to the swap recently, or been
pulled off recently.  I am not touching that.

Other things (not brought up by me) include making a central compression library for the
kernel (modular, i.e. modprobe zlib and such) (Jorn's idea).  That is something that I think
would be essential for swap compression; why should one module horde all the compression
algo's?

--Bluefox


