Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbUKJGCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUKJGCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 01:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbUKJGCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 01:02:34 -0500
Received: from peabody.ximian.com ([130.57.169.10]:60891 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261894AbUKJGCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 01:02:33 -0500
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and
	vmalloc)
From: Robert Love <rml@novell.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4191A4E2.7040502@gmx.net>
References: <4191A4E2.7040502@gmx.net>
Content-Type: text/plain
Date: Wed, 10 Nov 2004 01:03:17 -0500
Message-Id: <1100066597.18601.124.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 06:19 +0100, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> it seems there is a bunch of drivers which want to allocate memory as
> efficiently as possible in a wide range of allocation sizes. XFS and
> NTFS seem to be examples. Implement a generic wrapper to reduce code
> duplication.
> Functions have the my_ prefixes to avoid name clash with XFS.

No, no, no.  A good patch would be fixing places where you see this.

Code needs to conscientiously decide to use vmalloc over kmalloc.  The
behavior is different and the choice needs to be explicit.

	Robert Love
 

