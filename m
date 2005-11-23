Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVKWTKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVKWTKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVKWTKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:10:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932224AbVKWTKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:10:14 -0500
Date: Wed, 23 Nov 2005 11:09:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, dalomar@serrasold.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/3] NOMMU: Provide shared-writable mmap support on ramfs
In-Reply-To: <dhowells1132772387@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0511231109040.13959@g5.osdl.org>
References: <dhowells1132772387@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, David Howells wrote:
> 
>  (3) Not permitting a file to be shrunk if it would truncate any shared
>      mappings (private mappings are copied).

Why?

Truncate is _supposed_ to get rid of any shared mmap stuff. 

		Linus
