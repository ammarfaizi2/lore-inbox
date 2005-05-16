Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVEPW2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVEPW2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVEPW1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:27:09 -0400
Received: from main.gmane.org ([80.91.229.2]:16564 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261966AbVEPW02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:26:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Tristan Wibberley <maihem@maihem.org>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Mon, 16 May 2005 23:22:11 +0100
Message-ID: <1116282131.6141.8.camel@localhost.localdomain>
References: <200505151122.j4FBMJa01073@adam.yggdrasil.com>
	 <20050515124042.GE13024@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host81-156-255-228.range81-156.btcentralplus.com
In-Reply-To: <20050515124042.GE13024@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-15 at 14:40 +0200, Petr Baudis wrote:
> Dear diary, on Sun, May 15, 2005 at 01:22:19PM CEST, I got a letter
> where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> > 
> > 	I don't understand what was wrong with Jeff Garzik's previous
> > suggestion of using http/1.1 pipelining to coalesce the round trips.
> > If you're worried about queuing too many http/1.1 requests, the client
> > could adopt a policy of not having more than a certain number of
> > requests outstanding or perhaps even making a new http connection
> > after a certain number of requests to avoid starving other clients
> > when the number of clients doing one of these transfers exceeds the
> > number of threads that the http server uses.
> 
> The problem is that to fetch a revision tree, you have to
> 
> 	send request for commit A
> 	receive commit A
> 	look at commit A for list of its parents
> 	send request for the parents
> 	receive the parents
> 	look inside for list of its parents
> 	...

What about IMAP? You could ask for just the parents for several messages
(via a message header), then start asking for message bodies (with the
juicy stuff in). You could also ask for a list of the new commits then
ask for each of the bodies (several at a time). Not as good as a "Just
give me all new data", but an *awful* lot more efficient than HTTP. And
very flexible. You just need to map changesets to IMAP messages (if such
a mapping can actually make sense :)

Prolly a bit more work though.

--
Tristan Wibberley

The opinions expressed in this message are my own opinions and not those
of my employer.


