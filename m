Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWEVBBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWEVBBF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 21:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWEVBBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 21:01:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964971AbWEVBBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 21:01:03 -0400
Date: Sun, 21 May 2006 18:00:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: hch@lst.de, bcrl@kvack.org, cel@citi.umich.edu, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use
 aio_read/aio_write instead
Message-Id: <20060521180037.3c8f2847.akpm@osdl.org>
In-Reply-To: <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
	<1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> This patch removes readv() and writev() methods and replaces
>  them with aio_read()/aio_write() methods.

And it breaks autofs4

autofs: pipe file descriptor does not contain proper ops

