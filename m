Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289629AbSAOUDu>; Tue, 15 Jan 2002 15:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289639AbSAOUDk>; Tue, 15 Jan 2002 15:03:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38406 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289629AbSAOUDe>; Tue, 15 Jan 2002 15:03:34 -0500
Message-ID: <3C448B01.6030003@zytor.com>
Date: Tue, 15 Jan 2002 12:03:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16QXbx-0000wa-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> 
> Encoding the numeric fields in ASCII/hex is a goofy wart on an otherwise nice 
> design.  What is the compelling reason?  Bytesex isn't it: we should just 
> pick one or the other and stick with it as we do in Ext2.
> 
> Why don't we fix cpio to write a consistent bytesex?
> 


Because we want to use existing tools.  It's a wart, but not compelling 
enough of one to rewrite the tools from scratch.  (I would also change 
the EOA marker from "TRAILER!!!" to "" since a null filename would not 
interfere with the namespace.)

I don't think think this application alone is enough to add Yet Another 
Version of CPIO.  However, if there are more compelling reasons to do so 
  for CPIO backup reasons itself I guess we could write it up and add it 
to GNU cpio as "linux" format...

	-hpa


