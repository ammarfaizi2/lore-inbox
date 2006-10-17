Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423188AbWJQJEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423188AbWJQJEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 05:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423189AbWJQJEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 05:04:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56457 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423186AbWJQJEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 05:04:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061017005025.GF29920@ftp.linux.org.uk> 
References: <20061017005025.GF29920@ftp.linux.org.uk> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 17 Oct 2006 10:04:00 +0100
Message-ID: <27543.1161075840@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> 	* sizeof(*ptr) should be one of 1, 2, 4, 8

Should we give an error if someone tries passing a 1-byte-sized memory location
to get/put_unaligned()?  I suspect it might be best to reduce to a trivial
direct assignment in that case.

David
