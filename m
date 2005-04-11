Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVDKUr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVDKUr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVDKUr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:47:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32180 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261910AbVDKUrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:47:23 -0400
Date: Mon, 11 Apr 2005 13:46:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
Message-ID: <419860000.1113252411@flay>
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, April 11, 2005 01:25:32 -0700 Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> 
> - The anticipatory I/O scheduler has always been fairly useless with SCSI
>   disks which perform tagged command queueing.  There's a patch here from Jens
>   which is designed to fix that up by constraining the number of requests
>   which we'll leave pending in the device.
> 
>   The depth currently defaults to 1.  Tunable in
>   /sys/block/hdX/queue/iosched/queue_depth
> 
>   This patch hasn't been performance tested at all yet.  If you think it is
>   misbehaving (the usual symptom is processes stuck in D state) then please
>   report it, then boot with `elevator=cfq' or `elevator=deadline' to work
>   around it.
> 
> - More CPU scheduler work.  I hope someone is testing this stuff.

Trying ... having some build problems that seem to be part test-harness,
part bugs.

Meanwhile on PPC64: 

fs/cifs/misc.c: In function `cifs_convertUCSpath':
fs/cifs/misc.c:546: error: case label does not reduce to an integer constant
fs/cifs/misc.c:549: error: case label does not reduce to an integer constant
fs/cifs/misc.c:552: error: case label does not reduce to an integer constant
fs/cifs/misc.c:561: error: case label does not reduce to an integer constant
fs/cifs/misc.c:564: error: case label does not reduce to an integer constant
fs/cifs/misc.c:567: error: case label does not reduce to an integer constant
make[2]: *** [fs/cifs/misc.o] Error 1
make[1]: *** [fs/cifs] Error 2
make[1]: *** Waiting for unfinished jobs....


M.

