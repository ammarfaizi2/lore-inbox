Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312853AbSCZXqA>; Tue, 26 Mar 2002 18:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312852AbSCZXpu>; Tue, 26 Mar 2002 18:45:50 -0500
Received: from cpe.atm0-0-0-1221082.0x3ef261a2.bynxx2.customer.tele.dk ([62.242.97.162]:2688
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S312850AbSCZXph>; Tue, 26 Mar 2002 18:45:37 -0500
Message-ID: <3CA1081D.7040101@fugmann.dhs.org>
Date: Wed, 27 Mar 2002 00:45:33 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020326 Debian/2:0.9.9-3pre4v3
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre4-ac1
In-Reply-To: <E16pvYV-0003cD-00@the-village.bc.nu>	<3CA0EAAA.8000400@fugmann.dhs.org> <15520.61687.962869.841296@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

It seems that there is some more problems.
I have not verified the lookup (since I just booted right away with the patch), but
I have found that:

Mar 26 23:56:58 gw kernel: nfsd: LOOKUP(3)   24: 03000001 03000900 00000002 0000106d 0000106c 0000070d WMRootMenu
Mar 26 23:56:58 gw kernel: RPC request reserved 240 but used 244

Mar 27 00:30:09 gw kernel: nfsd: CREATE(3)   24: 03000001 03000900 00000002 00000003 00000002 00000000 test
Mar 27 00:30:09 gw kernel: RPC request reserved 272 but used 276

Mar 27 00:30:21 gw kernel: nfsd: SYMLINK(3)  24: 03000001 03000900 00000002 00000003 00000002 00000000 test1 -> test
Mar 27 00:30:21 gw kernel: RPC request reserved 272 but used 276

And there might be others.

I would be happy to post a patch, but I do not know the
exact reason for the calculations in struct svc_procedure.
I guess that it has to do with how the request is constructed.

Regards
Anders Fugmann




