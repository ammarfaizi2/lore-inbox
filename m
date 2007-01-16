Return-Path: <linux-kernel-owner+w=401wt.eu-S1751472AbXAPUcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbXAPUcq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXAPUcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:32:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:60711 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbXAPUcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:32:45 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: O_DIRECT question
To: Helge Hafting <helge.hafting@aitel.hist.no>,
       Michael Tokarev <mjt@tls.msk.ru>, Chris Mason <chris.mason@oracle.com>,
       Linus Torvalds <torvalds@osdl.org>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Reply-To: 7eggert@gmx.de
Date: Tue, 16 Jan 2007 21:26:55 +0100
References: <7BYkO-5OV-17@gated-at.bofh.it> <7BYul-6gz-5@gated-at.bofh.it> <7C74B-2A4-23@gated-at.bofh.it> <7CaYA-mT-19@gated-at.bofh.it> <7Cpuz-64X-1@gated-at.bofh.it> <7Cz0T-4PH-17@gated-at.bofh.it> <7CBcl-86B-9@gated-at.bofh.it> <7CBvH-52-9@gated-at.bofh.it> <7DyYK-6lE-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1H6utT-0000g3-Aw@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> Michael Tokarev wrote:

>> But seriously - what about just disallowing non-O_DIRECT opens together
>> with O_DIRECT ones ?
>>   
> Please do not create a new local DOS attack.
> I open some important file, say /etc/resolv.conf
> with O_DIRECT and just sit on the open handle.
> Now nobody else can open that file because
> it is "busy" with O_DIRECT ?

Suspend O_DIRECT access while non-O_DIRECT-fds are open, fdatasync on close?
-- 
"Unix policy is to not stop root from doing stupid things because
that would also stop him from doing clever things." - Andi Kleen

"It's such a fine line between stupid and clever" - Derek Smalls
