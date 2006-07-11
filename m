Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWGKRnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWGKRnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWGKRnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:43:52 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45989 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751147AbWGKRnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:43:52 -0400
Date: Tue, 11 Jul 2006 13:43:31 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH] Introduce list_get() and list_get_tail()
Message-ID: <20060711174331.GA1666@filer.fsl.cs.sunysb.edu>
References: <200607080124.21856.dtor@insightbb.com> <p73wtaonqow.fsf@verdi.suse.de> <1152368186.3120.50.camel@laptopd505.fenrus.org> <200607082328.48575.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607082328.48575.dtor@insightbb.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 11:28:47PM -0400, Dmitry Torokhov wrote:
...
> +#define list_next_entry list_first_entry

list_next_entry, that sounds almost as something which given any list_head
will give you the next entry. That's all fine until you give it the last
list_head in the list - you'll try to use list_entry on a list_head that's
not part of a struct but is the head of the list instead.

> +#define list_prev_entry list_last_entry

Ditto.

Jeff.

-- 
Note 96.3% of all statistics are fiction.
