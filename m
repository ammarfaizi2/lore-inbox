Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263697AbUE1Q5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUE1Q5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUE1Q5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:57:07 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:64945 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263772AbUE1Q4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:56:52 -0400
From: "braam" <braam@clusterfs.com>
To: <arjanv@redhat.com>, <hch@infradead.org>
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: RE: [PATCH/RFC] Lustre VFS patch
Date: Sat, 29 May 2004 00:56:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <1085406284.2780.13.camel@laptop.fenrus.com>
Thread-Index: AcRBlUgsCy3m3OkDSbK8YehV/86AmgDB3YzQ
Message-Id: <20040528165649.91F1F3100D3@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan, 

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjanv@redhat.com] 
> 
> fun question: how does it deal with say a rename that would 
> span mounts on the client but wouldn't on the server? :)


Mostly checks are done like in sys_rename.  

Some cases require new distributed state in the FS, such as the fact that a
certain directory is a mountpoint, possibly not on the node doing a rename,
but on another node.  

For this the Linux VFS has no api - we added something we call "pinning" for
this in 2.4, but not in 2.6 yet.

- Peter -

