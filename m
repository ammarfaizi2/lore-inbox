Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTENQCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTENQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:02:33 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:23228 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S262530AbTENQCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:02:31 -0400
Date: Wed, 14 May 2003 12:13:03 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Yoav Weiss <ml-lkml@unpatched.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <20030514155727.GA16093@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.33.0305141211070.12082-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 May 2003, [iso-8859-1] Jörn Engel wrote:
> sense to me.
>
> 1. Instead of cryptographic filesystems, you could just encrypt the
>    block device.
> 2. The only reason not to do so it security.  An attacker could use
>    known-plaintext attacks, since some parts of the metadata can be
>    reconstructed or guessed easily.
> 3. Instead of encrypted swap, you could just encrypt the block device.
> 4. The only reason reason not to do so is what?
>

The idea is to have encryption keys for the pages to be unique on a
per-uid per-process basis. So one user on the system cannot access (even
if they are root) parts of another's private data.  To achieve this,
different parts of swap device need to be encrypted with different keys.

Ahmed.


