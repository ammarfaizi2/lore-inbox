Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSGVInS>; Mon, 22 Jul 2002 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSGVInS>; Mon, 22 Jul 2002 04:43:18 -0400
Received: from mons.uio.no ([129.240.130.14]:10180 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316589AbSGVInR> convert rfc822-to-8bit;
	Mon, 22 Jul 2002 04:43:17 -0400
To: "Nils O. =?iso-8859-1?q?Sel=E5sdal?=" <noselasd@Utel.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS unlink race?
References: <200207220754.g6M7sJ429182@localhost.localdomain>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Jul 2002 10:46:19 +0200
In-Reply-To: <200207220754.g6M7sJ429182@localhost.localdomain>
Message-ID: <shswurop2uc.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Nils O Selåsdal <noselasd@Utel.no> writes:

     > Seems like there went some patches into 2.5 to fix some nfs
     > unlink races
     > (http://linux.bkbits.net:8080/linux-2.5/cset@1.681.1.1?nav=index.html|ChangeSet@-1d)
     > Does this race apply to 2.4 as well? And might that explain why

A race exists, but it won't explain your problem. The nature of the
race is rather that it will cause a program to crash with ESTALE
errors if it tries to open the file at the exact same time as somebody
else is trying to erase it.

Cheers,
  Trond
