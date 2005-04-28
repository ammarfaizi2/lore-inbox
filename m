Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVD1I4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVD1I4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVD1I4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:56:00 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:10925 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261969AbVD1IzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:55:21 -0400
Message-Id: <6.0.0.20.2.20050428151420.03d5c6f0@mailsv2.y.ecl.ntt.co.jp>
X-Mailer: QUALCOMM Windows Eudora Version 6J-Jr3
Date: Thu, 28 Apr 2005 17:54:42 +0900
To: "Stephen C. Tweedie" <sct@redhat.com>
From: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please
  check)
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1114640549.4885.25.camel@sisko.sctweedie.blueyonder.co.uk>
References: <20050326162801.GA20729@logos.cnet>
 <20050328073405.GQ16169@viasys.com>
 <20050328165501.GR16169@viasys.com>
 <16968.40186.628410.152511@cse.unsw.edu.au>
 <20050329215207.GE5018@logos.cnet>
 <16970.9679.874919.876412@cse.unsw.edu.au>
 <20050330115946.GA7331@logos.cnet>
 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
 <1113402868.3019.27.camel@sisko.sctweedie.blueyonder.co.uk>
 <1114640549.4885.25.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At 07:22 05/04/28, Stephen C. Tweedie wrote:
 >In checking out the patch one last time, though, I found one anomaly.
 >The patch that was submitted to 2.6 for this problem also changed
 >write_inode_now() to return an error value.  The patch that got
 >submitted to 2.4 had no such change.  Was there a reason for this
 >difference between the two versions?

Right. Also in ver 2.4, I know write_inode_now() has to be changed for perfect
I/O error detection during synchronous writing.

In do_generic_file_write(mm/filemap.c), does the current return value handling is
unchanged?

Thanks, 

