Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTLEMLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 07:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTLEMLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 07:11:12 -0500
Received: from main.gmane.org ([80.91.224.249]:51390 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263969AbTLEMLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 07:11:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Fri, 05 Dec 2003 13:11:03 +0100
Message-ID: <yw1xllprihwo.fsf@kth.se>
References: <200312041432.23907.rob@landley.net> <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ShyW8RuyCNow4ZhvqdbGQleNURU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szakacsits Szabolcs <szaka@sienet.hu> writes:

>> What are the downsides of holes?  [...] is there a performance penalty to
>> having a file with 1000 4k holes in it, etc...)
>
> Depends what you do, what fs you use. Using XFS XFS_IOC_GETBMAPX you might
> get a huge improvement, see e.g. some numbers,
>
> 	http://marc.theaimsgroup.com/?l=reiserfs&m=105827549109079&w=2
>
> The problem is, 0 general purpose (like cp, tar, cat, etc) util supports
> it, you have to code your app accordingly.

I found this paragraph in the man page of GNU cp:

       --sparse=WHEN
              A `sparse file' contains  `holes'  -  sequences  of
              zero  bytes  that  do  not occupy any physical disk
              blocks; the  `read'  system  call  reads  these  as
              zeroes.  This can both save considerable disk space
              and increase speed, since many binary files contain
              lots  of  consecutive  zero  bytes.  By default, cp
              detects holes in input source  files  via  a  crude
              heuristic  and  makes the corresponding output file
              sparse as well.

              The WHEN value can be one of the following:

              auto   The default behavior:  the  output  file  is
                     sparse if the input file is sparse.

              always Always make the output file sparse.  This is
                     useful when the  input  file  resides  on  a
                     filesystem  that  does  not  support  sparse
                     files, but the output file is on a  filesys-
                     tem that does.

              never  Never  make  the output file sparse.  If you
                     find an application for this option, let  us
                     know.


-- 
Måns Rullgård
mru@kth.se

