Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUDDTqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUDDTqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 15:46:25 -0400
Received: from stogtw01.enlight.net ([212.209.183.10]:33051 "EHLO
	stodns01.enlightnet.local") by vger.kernel.org with ESMTP
	id S262703AbUDDTqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 15:46:24 -0400
Date: Sun, 4 Apr 2004 21:46:15 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Kyle Davenport <kdd@tvmax.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.25 crashes windows
In-Reply-To: <1081098190.14744.90.camel@quickest.kyledavenport.com>
Message-ID: <Pine.LNX.4.44.0404042132201.28197-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Apr 2004 19:46:20.0799 (UTC) FILETIME=[80D678F0:01C41A7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2004, Kyle Davenport wrote:

> No joke.  64-bit Windows Advanced Server 2003 blue-screens on file share
> access.  I was using Samba 3.0 on RH8 to routinely access windows
> shares.  When I upgraded from 2.4.22 to 2.4.25, any attempt to access a
> sub-directory of a share mounted from 64-bit Win2003, immediately
> crashes windows.  I rolled back to 2.4.22 and no crash.  I tried 2.4.25
> against a 32-bit 2003 Win2003, and no crash.  I didn't test different
> versions of Samba.  But on 2.4.25, trying to ls a sub-directory of the
> mounted share or cd to that sub-directory, instantly and repeatedly
> blue-screens windows.  

When you say mount, does that mean smbfs?

2.4.25 allows you to enable the cifs unix extensions in smbfs. Perhaps
turning those off makes a difference?

The other change is that smbfs in 2.4.25 has large file support. smbfs in 
2.4.24 should behave like 2.4.22.


> I have no idea how the kernel change could be causing this.  Seems to me
> like it should depend entirely on Samba.  I did attempt to reproduce the

smbmount is only a mount tool, it does not transfer any other data.

/Urban

