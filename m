Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVFHOvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFHOvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVFHOvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:51:55 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:56285 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261285AbVFHOvs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:51:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
Date: Wed, 8 Jun 2005 16:24:37 +0200
User-Agent: KMail/1.7.2
Cc: Arjan van de Ven <arjan@infradead.org>, christoph <christoph@scalex86.org>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw> <1118177949.5497.44.camel@laptopd505.fenrus.org> <42A61227.9090402@didntduck.org>
In-Reply-To: <42A61227.9090402@didntduck.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506081624.41995.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 07 Juni 2005 23:31, Brian Gerst wrote:
> 
> It doesn't really matter.  .rodata isn't actually mapped read-only. 
> Doing so would break up the large pages used to map the kernel.

There are some platforms that are able to have the .rodata section
of the kernel in ROM, and not all architectures support large pages,
so putting syscall_table and others into ROM could be a noticeable
advantage.

	Arnd <><
