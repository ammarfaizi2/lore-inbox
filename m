Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTKKTAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTKKTAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:00:06 -0500
Received: from csl2.consultronics.on.ca ([204.138.93.2]:28344 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S263693AbTKKTAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:00:04 -0500
Date: Tue, 11 Nov 2003 14:00:00 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre8-pac1 and -rc1-pac1 NFSv3 problem
Message-ID: <20031111190000.GA25290@athame.dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <20031111182647.GA25026@athame.dynamicro.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031111182647.GA25026@athame.dynamicro.on.ca>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20031111 (Tue) at 1326:47 -0500, Greg Louis wrote:
> Kernels 2.4.23-pre7-pac1 and 2.4.23-rc1 are ok but -pre8-pac1 and
> -rc1-pac1 behave as follows: mounting a remote directory via NFS with
> v3 enabled (client and server) seems to work ok, and running mount with
> no parameters shows the NFS mount, but any attempt at access fails with
> a message like
>   /bin/ls: reading directory /whatever/it/was: Input/output error

Reverting all changes to fs/nfs/* since 2.4.23-pre7-pac1, and only
those, corrects the problem.

-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |
