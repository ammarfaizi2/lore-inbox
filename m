Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWGDMws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWGDMws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWGDMws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:52:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54994 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750875AbWGDMwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:52:47 -0400
Subject: Re: R/W semaphore changes
From: Arjan van de Ven <arjan@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <14683.1152017262@warthog.cambridge.redhat.com>
References: <14683.1152017262@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 14:52:42 +0200
Message-Id: <1152017562.3109.48.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 13:47 +0100, David Howells wrote:
> I see you've made some R/W semaphore changes...
> 
> | /*
> |  * nested locking:
> |  */
> 
> This comment is inadequate.  Please be more explicit about when you're allowed
> to do this.
> 
> | extern void down_read_nested(struct rw_semaphore *sem, int subclass);
> | extern void down_write_nested(struct rw_semaphore *sem, int subclass);
> 
> Please, please, please don't.  R/W semaphores are _not_ permitted to nest.

yet they do in places, there where there is a natural hierarchy..

> | # define down_read_nested(sem, subclass)		down_read(sem)
> | # define down_write_nested(sem, subclass)	down_write(sem)
> 
> This is _not_ okay.

why not?



