Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTEEJZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 05:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTEEJZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 05:25:44 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34066 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262120AbTEEJZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 05:25:43 -0400
Date: Mon, 5 May 2003 09:38:10 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505093810.A22327@devserv.devel.redhat.com>
References: <1052122784.2821.4.camel@pc-16.office.scali.no> <20030505092324.A13336@infradead.org> <1052127216.2821.51.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052127216.2821.51.camel@pc-16.office.scali.no>; from terje.eggestad@scali.com on Mon, May 05, 2003 at 11:33:36AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 11:33:36AM +0200, Terje Eggestad wrote:
> 1. performance is everything. 
> 2. We're making a MPI library, and as such we don't have any control
> with the application. 
> 3a. The various hardware for cluster interconnect all work with DMA. 
> 3b. the performance loss from copying from a receive area to the
> userspace buffer is unacceptable. 
> 3c. It's therefore necessary for HW to access user pages. 
> 4. In order to to 3, the user pages must be pinned down. 

see how AIO does this, and O_DIRECT, and rawio.

They all have the same requirement and manage to cope.
