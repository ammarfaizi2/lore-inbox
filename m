Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265294AbSJXDE3>; Wed, 23 Oct 2002 23:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265295AbSJXDE3>; Wed, 23 Oct 2002 23:04:29 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:24850 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265294AbSJXDE3>; Wed, 23 Oct 2002 23:04:29 -0400
Message-ID: <3DB764B0.3010204@namesys.com>
Date: Thu, 24 Oct 2002 07:10:40 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared	forvarious
  fs.
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov> 	<3DB6FF24.9B50A7C0@digeo.com> <1035405140.13083.268.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please repeat the test using a tarball created from a reiserfs 
partition, you'll get better numbers for reiserfs.  Not as good as 
reiser4, but still much better than these.

File order from readdir matters a lot.

It is a bit amazing how many obscurities can bite you with seemingly 
simple tests like this.  We recently ran into one with tar recognizing 
that it was writing to /dev/null, and optimizing for it.

Hans

