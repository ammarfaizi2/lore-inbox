Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318099AbSGWQRR>; Tue, 23 Jul 2002 12:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318126AbSGWQRR>; Tue, 23 Jul 2002 12:17:17 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:4364 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318099AbSGWQRQ>; Tue, 23 Jul 2002 12:17:16 -0400
Date: Tue, 23 Jul 2002 17:20:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: axel@hh59.org, linux-kernel@vger.kernel.org,
       jfs-discussion@www-124.southbury.usf.ibm.com
Subject: Re: [Jfs-discussion] Re: 2.5.27: Software Suspend failure / JFS errors
Message-ID: <20020723172025.A25091@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>, axel@hh59.org,
	linux-kernel@vger.kernel.org,
	jfs-discussion@www-124.southbury.usf.ibm.com
References: <20020721122932.GA23552@neon.hh59.org> <200207230954.36039.shaggy@austin.ibm.com> <20020723160657.A23708@infradead.org> <200207231115.14780.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207231115.14780.shaggy@austin.ibm.com>; from shaggy@austin.ibm.com on Tue, Jul 23, 2002 at 11:15:14AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 11:15:14AM -0500, Dave Kleikamp wrote:
> On Tuesday 23 July 2002 10:06, Christoph Hellwig wrote:
> > As I read 'Software Suspend' in the subject I guess it's swsusp
> > fault. Swsusp needs magic flags for kernel threads which no one has
> > added to JFS yet.
> 
> I understood the swsusp to be an unrelated issue.  Is swsusp even 
> available in a 2.4 kernel?

There is a 2.4 patch and it was merged in -ac for some period.

> I believe to fix the swsusp problem, the kernel threads need to test 
> (current->flags & PF_FREEZE), and if set call 
> refrigerator(PF_IOTHREAD).

I think so.  (although I have to admit that I don't care for it)
