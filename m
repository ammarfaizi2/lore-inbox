Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbUJYJui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUJYJui (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUJYJui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:50:38 -0400
Received: from canuck.infradead.org ([205.233.218.70]:59144 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261738AbUJYJsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:48:36 -0400
Subject: Re: [PATCH] Shift key-related error codes up and insert ECANCELED
From: Arjan van de Ven <arjan@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org,
       jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <14486.1098696661@redhat.com>
References: <1098470076.19458.37.camel@localhost.localdomain>
	 <20498.1098464262@redhat.com>   <14486.1098696661@redhat.com>
Content-Type: text/plain
Message-Id: <1098697701.2798.12.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 25 Oct 2004 11:48:21 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 10:31 +0100, David Howells wrote:
>  Take open() for
> example: it's possible that this will return ENOENT because there's no file
> there to be opened; I think it's a bad idea for it to return ENOENT when there
> is a file there, but we don't have a key, hence ENOKEY.

take open....
you don't have access to the file because you don't have a matching key
to get to it. Doesn't that kinda say EACCESS (or EPERM) would be a/the
proper return code ?
-- 

