Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVDGDBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVDGDBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 23:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDGDBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 23:01:04 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:62162 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261199AbVDGDA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 23:00:58 -0400
Message-Id: <6.0.0.20.2.20050407113355.03cce2d0@mailsv2.y.ecl.ntt.co.jp>
X-Mailer: QUALCOMM Windows Eudora Version 6J-Jr3
Date: Thu, 07 Apr 2005 12:00:30 +0900
To: "Stephen C. Tweedie" <sct@redhat.com>
From: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please
  check)
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112797205.3377.16.camel@sisko.sctweedie.blueyonder.co.uk>
References: <20050326162801.GA20729@logos.cnet>
 <20050328073405.GQ16169@viasys.com>
 <20050328165501.GR16169@viasys.com>
 <16968.40186.628410.152511@cse.unsw.edu.au>
 <20050329215207.GE5018@logos.cnet>
 <16970.9679.874919.876412@cse.unsw.edu.au>
 <20050330115946.GA7331@logos.cnet>
 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
 <1112797205.3377.16.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 23:20 05/04/06, Stephen C. Tweedie wrote:
 >Yes.  But it is conventional to interpret a short write as being a
 >failure.  Returning less bytes than were requested in the write
 >indicates that the rest failed.  It just doesn't give the exact nature
 >of the failure (EIO vs ENOSPC etc.)  For regular files, a short write is
 >never permitted unless there are errors of some description.

When commit_write() FULLY succeed (requested bytes == returned bytes) but
generic_osync_inode() return error due to I/O failure, current 
do_generic_file_write() cannot
return error. I encountered above situation a lot under an I/O trouble 
condition .

In ver 2.6.11, the return value of generic_osync_inode() is returned 
directry to user
when I/O failure occur.


thanks.

   

