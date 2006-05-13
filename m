Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWEMLXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWEMLXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWEMLXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:23:10 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:15622 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S932369AbWEMLXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:23:09 -0400
Date: Sat, 13 May 2006 21:23:37 +1000
From: CaT <cat@zip.com.au>
To: Mark Rosenstand <mark@borkware.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
Message-ID: <20060513112337.GB4288@zip.com.au>
References: <20060513103841.B6683146AF@hunin.borkware.net> <1147517786.3217.0.camel@laptopd505.fenrus.org> <20060513110324.10A38146AF@hunin.borkware.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513110324.10A38146AF@hunin.borkware.net>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 01:03:24PM +0200, Mark Rosenstand wrote:
> It doesn't:
> 
> bash-3.00$ cat << EOF > test
> > #!/bin/sh
> > echo "yay, I'm executing!"
> > EOF
> bash-3.00$ chmod 111 test
> bash-3.00$ ./test
> /bin/sh: ./test: Permission denied

Obviously.

It executes the script, finds that it needs an interpreter and runs /bin/sh
as specified telling it to run the script. /bin/sh though needs to read
the script in and since the script has no read permissions it fails.
Hence permission denied.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
