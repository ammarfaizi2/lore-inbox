Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSE3VrK>; Thu, 30 May 2002 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSE3VrJ>; Thu, 30 May 2002 17:47:09 -0400
Received: from fungus.teststation.com ([212.32.186.211]:8203 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316896AbSE3VrJ>; Thu, 30 May 2002 17:47:09 -0400
Date: Thu, 30 May 2002 23:41:55 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Processes stuck in D state with autofs + smbfs
In-Reply-To: <20020530200332.GD1136@matchmail.com>
Message-ID: <Pine.LNX.4.33.0205302326400.4267-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002, Mike Fedyk wrote:

> Yes, the remote server was shut down and caused this problem.

Then that is probably why it fails, the NMI or any other problem is less 
likely. Please try:
http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.19-pre9-poll.patch

I haven't tested this particular patch, but it is a re-diff of an old one.
Should be ok with -pre6 too.

You don't need to modify samba, but you do need to enable "SMBFS Receive
timeout" in the kernel config.

/Urban

