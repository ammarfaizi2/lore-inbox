Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVEKQUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVEKQUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEKQUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:20:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26035 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261940AbVEKQTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:19:53 -0400
Subject: Re: [RFC/PATCH 0/5] add execute in place support
From: David Woodhouse <dwmw2@infradead.org>
To: cotte@freenet.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
In-Reply-To: <428216DF.8070205@de.ibm.com>
References: <428216DF.8070205@de.ibm.com>
Content-Type: text/plain
Date: Wed, 11 May 2005 17:19:48 +0100
Message-Id: <1115828389.16187.544.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 16:29 +0200, Carsten Otte wrote:
> . This is also useful on embedded systems where the block device is
> located on a flash chip.

On Wed, 2005-05-11 at 17:33 +0200, Carsten Otte wrote:
> Indeed that seems reasonable. There is no exact reason to have
> this built into a kernel on a platform that does not have a bdev
> for this.

The sanest way to use flash chips is not to pretend that they're a block
device at all; rather to use a file system directly on top of them. 

But although you _talk_ about block devices, your code does look like it
should be usable even by flash file systems. I'll try to come up with a
test case using it on flash.

-- 
dwmw2

