Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264000AbUD0Laz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbUD0Laz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 07:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbUD0Lay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 07:30:54 -0400
Received: from users.linvision.com ([62.58.92.114]:44265 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264000AbUD0Lax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 07:30:53 -0400
Date: Tue, 27 Apr 2004 13:30:52 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH COW] sys_copyfile
Message-ID: <20040427113052.GD6620@harddisk-recovery.com>
References: <20040426092045.GC895@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426092045.GC895@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 11:20:45AM +0200, J?rn Engel wrote:
> Adds a new syscall, copyfile() which does as the name sais.

I think it's actually better to use sendfile() rather then creating a
new syscall:

  ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count)

In that way you can create the file in the usual way and copy the
contents with an already existing syscall.

IMHO sendfile() has been a wrong name in the first place, copyfd()
would have been better. Why limit it to network traffic only?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
