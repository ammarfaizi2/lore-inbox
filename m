Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVFUXCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVFUXCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVFUW6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:58:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11686 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262424AbVFUW5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:57:17 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <christoph@lameter.com>
Cc: Zan Lynx <zlynx@acm.org>, Robert Love <rml@novell.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0506211306060.22372@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <1119368364.3949.236.camel@betsy>
	 <Pine.LNX.4.62.0506211222040.21678@graphe.net>
	 <1119382685.3949.263.camel@betsy> <1119384131.15478.25.camel@localhost>
	 <Pine.LNX.4.62.0506211306060.22372@graphe.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119394459.3279.196.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 23:54:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 21:06, Christoph Lameter wrote:
> On Tue, 21 Jun 2005, Zan Lynx wrote:
> 
> > I've never tried doing that.  It might work, for all I know.
> 
> I was told that Linux cannot do this. It always returns the filehandles as 
> ready for disk files.

That is because disk files are always ready - select/poll are for waits
for data (or space) to become available not for events in the sense of
inotify.
That said there *is* scope in the poll() API [but not select()] to add a
new kind of poll notification type.

