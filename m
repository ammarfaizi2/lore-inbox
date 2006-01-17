Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWAQK6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWAQK6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWAQK6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:58:24 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:43466 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932392AbWAQK6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:58:24 -0500
Date: Tue, 17 Jan 2006 19:58:27 +0900
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Keith Owens <kaos@ocs.com.au>, ak@suse.de, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 3/4] compact print_symbol() output
Message-ID: <20060117105826.GA24488@miraclelinux.com>
References: <20060117101555.GD19473@miraclelinux.com> <10099.1137494043@ocs3.ocs.com.au> <9a8748490601170252g1a89262n2745ef5bb3e1b16f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601170252g1a89262n2745ef5bb3e1b16f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 11:52:19AM +0100, Jesper Juhl wrote:
> On 1/17/06, Keith Owens <kaos@ocs.com.au> wrote:
> > Akinobu Mita (on Tue, 17 Jan 2006 19:15:55 +0900) wrote:
> > >- remove symbolsize field
> > >- change offset format from hexadecimal to decimal
> >
> > That is silly.  Almost every binutils tool prints offsets in hex,
> > including objdump and gdb.  Printing the trace offset in decimal just
> > makes more work for users to convert back to decimal to match up with
> > all the other tools.
> >
> Agreed.
> Also, hex output is shorter and often more natural for this type of data.
> 

In my vmlinux, 99.9% of the functions are smaller than 10000 bytes.

10000 == 0x2710
So. strlen("10000") == 5 < strlen("0x2710") == 6
Therefore call trace must be more compact.
