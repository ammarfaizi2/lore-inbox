Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUCTQss (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbUCTQss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:48:48 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:62338 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261474AbUCTQsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:48:47 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 20 Mar 2004 08:48:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
In-Reply-To: <s5gznab4lhm.fsf@patl=users.sf.net>
Message-ID: <Pine.LNX.4.44.0403200845200.2382-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar 2004, Patrick J. LoPresti wrote:

> What happens if the disk fills while you are making the copy?  Will
> open(2) on an *existing file* then return ENOSPC?
> 
> I do not think you can implement this without changing the interface
> to open(2).  Which means applications have to be made aware of it
> anyway.  Which means you might as well leave your implementation as-is
> and let userspace worry about creating the copy (and dealing with the
> resulting errors).

FWIW I did this quite some time ago to speed up copy+diff linux kernel 
trees:

http://www.xmailserver.org/flcow.html

It is entirely userspace and uses LD_PRELOAD on my dev shell.



- Davide


