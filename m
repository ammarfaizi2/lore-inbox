Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbTEEN3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTEEN3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:29:03 -0400
Received: from elin.scali.no ([62.70.89.10]:42117 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262191AbTEEN3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:29:01 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
In-Reply-To: <20030505135211.A21658@infradead.org>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <20030505112531.B16914@infradead.org>
	 <1052133798.2821.122.camel@pc-16.office.scali.no>
	 <20030505135211.A21658@infradead.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052142082.2821.169.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 May 2003 15:41:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

temper, temper

pls read my reply to alan carefully .

Doing  own malloc(), free(), m[un]map(), is a possibility we've
considered. Since we've got our own lib linked with the app, we probably
wouldn't even need LD_PRELOAD. our main issue is that not everything is
gcc/g77. 

Of all the approaches the syscall traps was the least intrusive and most
portable of all, belive it or not. 

BTW: this is all technical issues. 

On Mon, 2003-05-05 at 14:52, Christoph Hellwig wrote:

> 
> That only shows that you really don't want to use glibc's malloc and
> sbrk implementations, but ones that are implemented as mmap in your
> driver so you can keep track of it properly. LD_PRELOAD is your friend.


> Who cares about your trace module?  That's the wrong approach to start
> with.  And the removal of the sys_call_table export is not a political
> issue but a technical one.   The interesting thing would be your memory
> manager, but given the above hints you really should be able to fix it yourself
> now..
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

