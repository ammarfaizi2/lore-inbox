Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756704AbWKSOx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704AbWKSOx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756706AbWKSOx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:53:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:13025 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1756704AbWKSOx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:53:27 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: reiserfs NET=n build error
Date: Sun, 19 Nov 2006 15:53:13 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com> <20061119141355.GH31879@stusta.de>
In-Reply-To: <20061119141355.GH31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191553.13812.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Therefore, an EXPORT_SYMBOL in a lib-y object is a bug.


True. I think that got added when the EXPORT_SYMBOL was moved
into the individual .c file.

It would be better to move it back into some other file inside
a #ifdef CONFIG_NET. And fix reiserfs to not use it because
it shouldn't anyways.

-Andi

