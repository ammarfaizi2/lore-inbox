Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318193AbSGWQMX>; Tue, 23 Jul 2002 12:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSGWQMX>; Tue, 23 Jul 2002 12:12:23 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:32402 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318193AbSGWQMW>; Tue, 23 Jul 2002 12:12:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Jfs-discussion] Re: 2.5.27: Software Suspend failure / JFS errors
Date: Tue, 23 Jul 2002 11:15:14 -0500
X-Mailer: KMail [version 1.4]
Cc: axel@hh59.org, linux-kernel@vger.kernel.org,
       jfs-discussion@www-124.southbury.usf.ibm.com
References: <20020721122932.GA23552@neon.hh59.org> <200207230954.36039.shaggy@austin.ibm.com> <20020723160657.A23708@infradead.org>
In-Reply-To: <20020723160657.A23708@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207231115.14780.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 July 2002 10:06, Christoph Hellwig wrote:
> As I read 'Software Suspend' in the subject I guess it's swsusp
> fault. Swsusp needs magic flags for kernel threads which no one has
> added to JFS yet.

I understood the swsusp to be an unrelated issue.  Is swsusp even 
available in a 2.4 kernel?

I believe to fix the swsusp problem, the kernel threads need to test 
(current->flags & PF_FREEZE), and if set call 
refrigerator(PF_IOTHREAD).

-- 
David Kleikamp
IBM Linux Technology Center

