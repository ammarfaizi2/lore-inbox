Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269065AbUIHJmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269065AbUIHJmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUIHJmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:42:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65161 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269065AbUIHJmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:42:25 -0400
Subject: Re: [Patch 2/6]: ext3 reservations: Renumber the ext3 reservations
	ioctls
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Ram Pai <linuxram@us.ibm.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040907235327.A21397@infradead.org>
References: <200409071302.i87D2ROd030909@sisko.scot.redhat.com>
	 <20040907235327.A21397@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1094636497.1985.20.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Sep 2004 10:41:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-09-07 at 23:53, Christoph Hellwig wrote:

> Maybe you could reuse the XFS reservation ioctls instead of adding
> another set?  Having incompatible APIs for the same thing on different
> filesystems sounds like the wrong way to go.

I don't mind either way.  But I just looked, and I think they are doing
different things.  If I'm reading the XFS bits right, the XFS ioctls
actively reserve/free disk space; but the ext3 ones do nothing except
set/query the size of the per-inode sliding reservation window.

So sounds like they are best kept separate for now.

Cheers,
 Stephen

