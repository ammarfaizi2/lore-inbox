Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTIOPKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbTIOPKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:10:04 -0400
Received: from pat.uio.no ([129.240.130.16]:18584 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261460AbTIOPKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:10:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16229.54852.834931.495479@charged.uio.no>
Date: Mon, 15 Sep 2003 11:09:56 -0400
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre4 ide-scsi irq timeout
In-Reply-To: <20030915093110.GD2268@gamma.logic.tuwien.ac.at>
References: <20030913220121.GA1727@gamma.logic.tuwien.ac.at>
	<shs3cezap0u.fsf@charged.uio.no>
	<20030915093110.GD2268@gamma.logic.tuwien.ac.at>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Norbert Preining <preining@logic.at> writes:

     > Hmmm, that sounds very strange, since I used the same gcc for
     > the previous kernels (pre3 and before), too!?

If it's gcc-3.3.2-0pre3 (the current most recent gcc in sid) then I
spent most of Saturday compiling various kernels (including a 2.4.22
that used to work). Every kernel I compiled with that particular
revision showed the ide-scsi irq timeout bug on bootup. Furthermore,
/dev/hdc was unreadable...

Dropping back to gcc-3.2 and the same kernel, same config,
same... works fine (including 2.4.23-pre4).

Now it may indeed be that the problem is a missing 'barrier()' or
something like that in the ide code, but I haven't got the time to try
to track it down...

Cheers,
  Trond
