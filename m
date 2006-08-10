Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162226AbWHJNTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162226AbWHJNTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162223AbWHJNTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:19:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51415 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1162221AbWHJNTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:19:38 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [RFC] [PATCH] Relative lazy atime
To: Frank van Maarseveen <frankvm@frankvm.com>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Valerie Henson <val_henson@linux.intel.com>,
       Matthew Wilcox <matthew@wil.cx>, dean gaudet <dean@arctic.org>,
       David Lang <dlang@digitalinsight.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Reply-To: 7eggert@gmx.de
Date: Thu, 10 Aug 2006 15:07:31 +0200
References: <6Gts4-6UM-1@gated-at.bofh.it> <6GxFs-4Tg-13@gated-at.bofh.it> <6Gy8r-5Oh-11@gated-at.bofh.it> <6Gze7-7oP-7@gated-at.bofh.it> <6GCOJ-4fv-19@gated-at.bofh.it> <6GDB1-5qX-3@gated-at.bofh.it> <6GDKT-5Eb-37@gated-at.bofh.it> <6GHbD-2hm-1@gated-at.bofh.it> <6HQ3c-6Pf-9@gated-at.bofh.it> <6HVml-6DI-11@gated-at.bofh.it> <6Ih3l-5FP-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GBAGN-0000qC-V6@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen <frankvm@frankvm.com> wrote:

> I haven't seen anyone mentioning it but properly written cleanup programs
> for /tmp et.al. do depend on atimes. When a system crashes after a long
> time then (3) and (4) will probably cause /tmp to be wiped out because
> at the next boot all atimes will be really old.

s-/tmp-/var/tmp-, since you should expect /tmp to be wiped after a reboot
(especially if it's tmpfs).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
