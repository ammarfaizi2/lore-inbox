Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVFUUOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVFUUOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVFUUM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:12:56 -0400
Received: from graphe.net ([209.204.138.32]:20644 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261803AbVFUUKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:10:35 -0400
Date: Tue, 21 Jun 2005 13:10:26 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Robert Love <rml@novell.com>
cc: Zan Lynx <zlynx@acm.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
In-Reply-To: <1119384473.3949.279.camel@betsy>
Message-ID: <Pine.LNX.4.62.0506211309300.22490@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>  <42B831B4.9020603@pobox.com>
 <1119368364.3949.236.camel@betsy>  <Pine.LNX.4.62.0506211222040.21678@graphe.net>
  <1119382685.3949.263.camel@betsy> <1119384131.15478.25.camel@localhost> 
 <Pine.LNX.4.62.0506211306060.22372@graphe.net> <1119384473.3949.279.camel@betsy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Robert Love wrote:

> > I was told that Linux cannot do this. It always returns the filehandles as 
> > ready for disk files.
> 
> Inotify would definitely work.

Well we could use it in kernel to make select() work correctly. For disk 
files set up a notification for write and then only return from select if 
new data is available.

