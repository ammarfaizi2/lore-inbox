Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTDPKCf (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 06:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTDPKCf 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 06:02:35 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:29066
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264283AbTDPKCd 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 06:02:33 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: DMA transfers in 2.5.67
References: <200304160548_MC3-1-349F-E844@compuserve.com>
	<20030416031144.613b0cc7.akpm@digeo.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 16 Apr 2003 12:13:09 +0200
In-Reply-To: <20030416031144.613b0cc7.akpm@digeo.com>
Message-ID: <yw1xwuhuda2y.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> > # mount /ext3_fs
> > # time dd if=/ext3_fs/100MiB_file of=/dev/null bs=32k
> > 
> >   2.4.20aa1 : 3.3 sec (exactly what I expect to see)
> >   2.5.66    : 6.6 sec
> 
> With this test 2.4 will leave a lot more unwritten dirty data in memory.
> 
> You should include a `sync' in the timings.

That was reading a file discarding that data.  A sync shouldn't make
any difference.

-- 
Måns Rullgård
mru@users.sf.net
