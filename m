Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVEKPeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVEKPeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVEKPeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:34:10 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:11730 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261169AbVEKPeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:34:02 -0400
Message-ID: <428225E7.4070605@freenet.de>
Date: Wed, 11 May 2005 17:33:59 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: add execute in place support
References: <428216F7.30303@de.ibm.com> <20050511150924.GA29976@infradead.org>
In-Reply-To: <20050511150924.GA29976@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> This is a lot of code for a very special case.
>
>Could you try to put all the xip code into a separate file, e.g. mm/xip.c
>that's only built when CONFIG_XIP is set?  It would probably require
>duplicating a little more code if you want clean interfaces, e.g. probably
>a separate set of generic operations.
>
>  
>
Indeed that seems reasonable. There is no exact reason to have
this built into a kernel on a platform that does not have a bdev
for this. On the other hand, I believe the code should stay in
filemap.c, because it fits there conceptually. And I personally
dislike #ifdef in the middle of a file.
