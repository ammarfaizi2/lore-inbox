Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVKCBgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVKCBgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVKCBgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:36:40 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:57739
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030252AbVKCBgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:36:40 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: tmpfs (documentation?) bug
Date: Wed, 2 Nov 2005 16:57:26 -0600
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
References: <436847DD.5050504@ums.usu.ru>
In-Reply-To: <436847DD.5050504@ums.usu.ru>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511021657.26627.rob@landley.net>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 23:00, Alexander E. Patrakov wrote:
> Hello,
>
> Documentation/filesystems/tmpfs.c currently says:
>
> If nr_blocks=0 (or size=0), blocks will not be limited in that instance;
> if nr_inodes=0, inodes will not be limited.
>
> However, mounting a tmpfs with "mount -t tmpfs -o size=0 tmpfs
> /root/tmpfs" results in a tmpfs where only zero-sized files can live. So
> either this behaviour should be fixed to be in accordance with the
> documentation, or the documentation should reflect the current behaviour.

I like this behavior.  Please keep this behavior.  A dynamic /dev on tmpfs 
should _only_ have dentries (device nodes and symlinks), no actual files.  
I have a system that's currently using this to enforce that...

Rob
