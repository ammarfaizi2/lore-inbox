Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWEMLD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWEMLD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWEMLD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:03:26 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:15927 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S932338AbWEMLD0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:03:26 -0400
From: Mark Rosenstand <mark@borkware.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
In-Reply-To: <1147517786.3217.0.camel@laptopd505.fenrus.org>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060513110324.10A38146AF@hunin.borkware.net>
Date: Sat, 13 May 2006 13:03:24 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-05-13 at 12:38 +0200, Mark Rosenstand wrote:
> > Hi,
> > 
> > Is it in any (reasonable) way possible to make Linux support executable
> > shell scripts? Perhaps through binfmt_misc?
> 
> ehhhhhh this is already supposed to work.

It doesn't:

bash-3.00$ cat << EOF > test
> #!/bin/sh
> echo "yay, I'm executing!"
> EOF
bash-3.00$ chmod 111 test
bash-3.00$ ./test
/bin/sh: ./test: Permission denied

A more useful case is when you setuid the script (and no, this doesn't
need to be running as root and/or executable by all.)
