Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUB0A4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUB0A4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:56:23 -0500
Received: from pD9EF044B.dip.t-dialin.net ([217.239.4.75]:12275 "EHLO
	roesrv01.roemling.home") by vger.kernel.org with ESMTP
	id S261674AbUB0Azs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:55:48 -0500
Message-ID: <403E958B.6020406@roemling.net>
Date: Fri, 27 Feb 2004 01:55:39 +0100
From: Jochen Roemling <jochen@roemling.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net> <20040226163236.M22989@build.pdx.osdl.net>
In-Reply-To: <20040226163236.M22989@build.pdx.osdl.net>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>SuSE used to have a tool called compartment
>that helped with this, might google for it.
>  
>
sounds good, but does not work either :-(

roesrv01~ # compartment --cap CAP_IPC_LOCK bash
bash-2.05b# /sbin/getpcaps 3226
Capabilities for `3226': =ep cap_ipc_lock+i cap_setfcap-p cap_setpcap-ep
bash-2.05b# su - jochen
jochen@roesrv01:~> /sbin/getpcaps 3233
Capabilities for `3233': = cap_ipc_lock+i
jochen@roesrv01:~> ./a.out
Failure:: Operation not permitted
jochen@roesrv01:~> ps ax
[...]
 3226 pts/0    S      0:00 bash
 3233 pts/0    S      0:00 -su



