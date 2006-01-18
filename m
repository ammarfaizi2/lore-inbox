Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWARAoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWARAoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWARAoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:44:54 -0500
Received: from customer-148-235-52-40.uninet-ide.com.mx ([148.235.52.40]:52657
	"EHLO smtp.prodigy.net.mx") by vger.kernel.org with ESMTP
	id S932546AbWARAox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:44:53 -0500
Date: Tue, 17 Jan 2006 18:45:43 -0600
From: Gain Paolo Mureddu <gmureddu@prodigy.net.mx>
Subject: Problems building
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <43CD8FB7.90508@prodigy.net.mx>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Enigmail-Version: 0.93.0.0
X-imss-version: 2.035
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:3 C:4 M:4 S:4 R:4 (0.5000 0.5000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

    For some reason I am getting a strange message when I try to build
either -ck1 or 2, another message I tried to send to the list seems to
not have gotten where I intended to, I'm quoting that message here also:

Gain Paolo Mureddu wrote:

> So I have been struggling to get this kernel built, and apparently
> I've narrowed this down to the sched_iso3.2 and/or isobatch_ionice
> patches, however I can't be fully certain. Here is what is dumped
> to the console, I've gotten two dumps, this and one concerning
> sched.o, which I am still investigating. So here goes the dump:
>
> <build_dump> .... [snip] CC init/do_mounts_md.o In file included
> from include/linux/bio.h:25, from include/linux/blkdev.h:14, from
> include/linux/raid/md.h:21, from init/do_mounts_md.c:2:
> include/linux/ioprio.h: En la función ?task_nice_ioprio?:
> include/linux/ioprio.h:58: error: ?SCHED_BATCH? not declared here
> (first use in this function) include/linux/ioprio.h:58: error:
> (Each undeclared identifier is only reported once
> include/linux/ioprio.h:58: error: for each function it appears in.)
> include/linux/ioprio.h:60: error: ?SCHED_ISO? not declared here
> (first use in this function) make[1]: *** [init/do_mounts_md.o]
> Error 1 make: *** [init] Error 2 </build_dump> Anyone else with
> troubles in x86_64 systems?
>
> TIA!
>
I get the same error, thus far I know that the file in question
(iprio.h) inclues sched.h and that in sched.h SCHED_BATCH and
SCHED_ISO are defined, so why am I getting this error in the said
function, is beyond me.

Any pointers?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDzY+aXM+XOp70dwoRArWhAJ0QLlLrb5yGH+qOr0ByJVdAQDskCwCfTy8K
MXHVznEopuMqiaK/xh1PLmw=
=5WjR
-----END PGP SIGNATURE-----

