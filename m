Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTF0KeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTF0KeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:34:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55456 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264226AbTF0KeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:34:14 -0400
Date: Fri, 27 Jun 2003 12:48:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@digeo.com
Subject: Re: [BIO] request->flags ambiguity
Message-ID: <20030627104822.GE821@suse.de>
References: <20030627134756.4118617e.deepfire@ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627134756.4118617e.deepfire@ibe.miee.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27 2003, Samium Gromoff wrote:
> 	I might just be completely off base, but something struck me
> 	lately as odd, and i`d like to hear what you folks think about
> 	the issue.
> 
> 	I`m wondering about the ambiguity of the struct request->flags
> 	field.
> 
> 	Is it ok to have a possibility of a request with conflicting
> 	meanings attached to it?  For example REQ_CMD | REQ_PM_SHUTDOWN
> 	| REQ_SPECIAL.

No of course not.

> 	It may be, depending on the implementation, that they are not
> 	completely conflicting, but its hard to believe that there is
> 	zero ambiguity at all.
> 
> 	If i`m not mistaken this looks as creating opportunities for
> 	various subtle bugs.
> 
> 	Shouldn`t it make more sense to separate request-type-indicator
> 	flags into a separate unambiguous type field, which would take
> 	one of the following values: - read/write request - sense query
> 	- power control - special request
> 
> 	And not a currently possible combination of all of them, which
> 	seem to be the current situation.

There has been talk of that before, search the archives.

-- 
Jens Axboe

