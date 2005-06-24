Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263327AbVFXVrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263327AbVFXVrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbVFXVq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:46:59 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:41943 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263327AbVFXVoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:44:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KctIDi1mhFiVG/Fo9qkJqUJSnwdI+bt4jDcO95fjVDSjycD3UNOhMD/t4lpUAut5K9pJG2YPUj7OvdztcEK5lRJ225ymA3/4fqFpNvJsKiltUZGbALDWCVaHnG2/ZKo3FCqQatPIbyNm9RkEyprKUpHMseDw4FkwCem2ECzbO4Q=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Brian Minton <bminton@freeshell.org>
Subject: Re: oops while booting
Date: Sat, 25 Jun 2005 01:50:09 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050622033115.GA22543@SDF.LONESTAR.ORG>
In-Reply-To: <20050622033115.GA22543@SDF.LONESTAR.ORG>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506250150.10729.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 07:31, Brian Minton wrote:
> I captured these using serial console.

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4795

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.

> Call Trace:
>  [<c0213190>] memmove+0x50/0x54
>  [<c01b2e3c>] leaf_insert_into_buf+0xac/0x270
>  [<c019b4b4>] balance_leaf+0x1554/0x3090
>  [<c01aaad7>] ip_check_balance+0x2d7/0xbb0
>  [<c01aa1b5>] get_empty_nodes+0x155/0x1a0
>  [<c019d375>] do_balance+0x95/0x110
>  [<c01ac522>] fix_nodes+0x1c2/0x3e0
>  [<c01b9414>] reiserfs_insert_item+0x204/0x2d0
>  [<c01ba477>] indirect2direct+0x1d7/0x2d0
>  [<c01b88f3>] reiserfs_cut_from_item+0x483/0x560
>  [<c01b8d3e>] reiserfs_do_truncate+0x2be/0x5b0
>  [<c01a3d01>] reiserfs_truncate_file+0xf1/0x230
>  [<c01a58a1>] reiserfs_file_release+0x261/0x4a0
>  [<c016ff16>] open_namei+0xa6/0x630
>  [<c0126d95>] update_wall_time+0x15/0x40
>  [<c0160f4b>] __fput+0x11b/0x130
>  [<c015f589>] filp_close+0x59/0x90
>  [<c01724f8>] sys_dup2+0xc8/0x100
>  [<c0102f45>] syscall_call+0x7/0xb
