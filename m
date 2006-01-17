Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWAQLXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWAQLXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWAQLXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 06:23:16 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:8141 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932351AbWAQLXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 06:23:15 -0500
Date: Tue, 17 Jan 2006 20:23:18 +0900
To: Keith Owens <kaos@ocs.com.au>
Cc: ak@suse.de, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 3/4] compact print_symbol() output
Message-ID: <20060117112318.GA24671@miraclelinux.com>
References: <20060117101555.GD19473@miraclelinux.com> <10099.1137494043@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10099.1137494043@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 09:34:03PM +1100, Keith Owens wrote:
> Akinobu Mita (on Tue, 17 Jan 2006 19:15:55 +0900) wrote:
> >- remove symbolsize field
> >- change offset format from hexadecimal to decimal
> 
> That is silly.  Almost every binutils tool prints offsets in hex,
> including objdump and gdb.  Printing the trace offset in decimal just
> makes more work for users to convert back to decimal to match up with
> all the other tools.

Currently call trace on x86-64 prints offset in decimal.
Do you think it is better to print offset in hex on x86-64 too?
But Andi Kleen said he likes compact call trace in the reply to
my first version of these patches.

And do you have any objection to remove symbolsize output in
print_symbol()? I can't find useful usage about symbolsize in
print_symbol() except to do a double check that the oops is
matching the vmlinux we're looking at. (so I made 4/4)
Do you know any useful usage about symbolsize?
