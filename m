Return-Path: <linux-kernel-owner+w=401wt.eu-S932250AbXAIWfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbXAIWfY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbXAIWfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:35:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49113 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932250AbXAIWfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:35:23 -0500
Date: Tue, 9 Jan 2007 14:35:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tshighla@us.ibm.com, theotso@us.ibm.com
Subject: Re: [PATCH 0/3] eCryptfs: Support metadata in xattr
Message-Id: <20070109143519.dce0ed8b.akpm@osdl.org>
In-Reply-To: <20070109222107.GC16578@us.ibm.com>
References: <20070109222107.GC16578@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 16:21:07 -0600
Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> This patch set introduces the ability to store cryptographic metadata
> into an lower file extended attribute rather than the lower file
> header region.
> 
> This patch set implements two new mount options:
> 
> ecryptfs_xattr_metadata
>  - When set, newly created files will have their cryptographic
>    metadata stored in the extended attribute region of the file rather
>    than the header.

Why is this useful?

> ecryptfs_encrypted_view
>  - When set, this option causes eCryptfs to present applications a
>    view of encrypted files as if the cryptographic metadata were
>    stored in the file header, whether the metadata is actually stored
>    in the header or in the extended attributes.

Sounds kludgy.  "This mode of operation is useful for applications like
incremental backup utilities that do not preserve the extended attributes
when directly accessing the lower files.".  Wouldn't it be better to lean
on people to use better backup tools, and to fix existing ones?


