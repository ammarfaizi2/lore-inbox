Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTFXK61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFXK61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:58:27 -0400
Received: from mail.ithnet.com ([217.64.64.8]:50692 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261919AbTFXK50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:57:26 -0400
Date: Tue, 24 Jun 2003 13:11:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Cc: willy@w.ods.org, marcelo@conectiva.com.br, kpfleming@cox.net,
       stoffel@lucent.com, gibbs@scsiguy.com, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030624131138.249fb7df.skraw@ithnet.com>
In-Reply-To: <20030623133053.30d6cb88.skraw@ithnet.com>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030621105019.GA834@pcw.home.local>
	<20030623133053.30d6cb88.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, hello Willy,

I tried to produce the problem by using your chkblk tool, but was not
successful up to now. All checksums are the same. Is it possible that the
problem lies deeper in the process than expected. Remember I do:

copy data via NFS to server
tar data on server to tape
read data back vor verification with tar -d

Is it possible that the verification errors do not occur because of a read
problem, but because of a page cached block getting trashed somehow between
"tar to tape" and "read from tape". I would suspect that some blocks survive in
memory and are re-used during verification. If for some reason this data is
invalid or corrupted the verification fails although the read was correct.
I know that this sounds weird, but nevertheless possible, or not?
It may even be worse, the data may have also been left from the original nfs
action, correct?
Is there a way to completely invalidate/flush all cached blocks concerning this
fs (besides umount)?

Regards,
Stephan
