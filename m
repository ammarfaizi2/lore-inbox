Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUIORtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUIORtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUIORsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:48:11 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:44775 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S267184AbUIORp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:45:59 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-ID: <16712.32725.515306.890990@thebsh.namesys.com>
Date: Wed, 15 Sep 2004 21:45:57 +0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	<Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
	<20040915165450.GD6158@wohnheim.fh-wedel.de>
	<Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > 
 > On Wed, 15 Sep 2004, Jörn Engel wrote:
 > > 
 > > C now supports pointer arithmetic with void*?
 > 
 > C doesn't. gcc does. It's a documented extension, and it acts like if it 
 > was done on a byte.
 > 
 > See gcc's user guide "Extension to the C Language Family".
 > 
 > It's a singularly good feature. 

Unfortunately it breaks even better identity

  foo *p;

  p + nr == (foo *)((char *)p + nr * sizeof *p)

unless one thinks that is --together with gcc-- that nothing occupies
exactly one byte.

 > 
 > 		Linus

Nikita.

