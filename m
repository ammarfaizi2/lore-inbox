Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWFVDwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWFVDwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWFVDwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:52:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56510 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751292AbWFVDwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:52:15 -0400
Date: Wed, 21 Jun 2006 20:52:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, mbroz@redhat.com
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Message-Id: <20060621205206.35ecdbf8.akpm@osdl.org>
In-Reply-To: <20060621193121.GP4521@agk.surrey.redhat.com>
References: <20060621193121.GP4521@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 20:31:21 +0100
Alasdair G Kergon <agk@redhat.com> wrote:

> From: Milan Broz <mbroz@redhat.com>
>  
> Extend the core device-mapper infrastructure to accept arbitrary ioctls
> on a mapped device provided that it has exactly one target and it is 
> capable of supporting ioctls.

I don't understand that.  We're taking an ioctl against a dm device and
we're passing it through to an underlying device?  Or something else?

Care to flesh this out a bit?

> [We can't use unlocked_ioctl because we need 'inode': 'file' might be NULL.
> Is it worth changing this?]

It _should_ be possible to use unlocked_ioctl() - unlocked_ioctl() would be
pretty useless if someone was passing it a NULL file*.  More details?

