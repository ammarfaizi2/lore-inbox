Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbUKGNtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUKGNtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbUKGNtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:49:15 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:45319 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261621AbUKGNtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:49:09 -0500
Date: Sun, 7 Nov 2004 14:49:05 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: andyliu <liudeyan@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar file)
In-Reply-To: <aad1205e04110705073ee8399b@mail.gmail.com>
Message-ID: <Pine.LNX.4.60L.0411071408320.21903@rudy.mif.pg.gda.pl>
References: <aad1205e0411062306690c21f8@mail.gmail.com> 
 <595C7524-30A7-11D9-8C52-000D9352858E@mac.com> 
 <Pine.LNX.4.60L.0411071337240.21903@rudy.mif.pg.gda.pl>
 <aad1205e04110705073ee8399b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-611903269-1099835345=:21903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-611903269-1099835345=:21903
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 7 Nov 2004, andyliu wrote:
[..]
>>> Simply wonderful!
>>
>> Which is ~equal to .. unpack tarfile.tar to /dir/to/mnt :o)
> if the tarfile.tar contain huge little file and unpack it will cost
> time and much disk space.

1) This tarfs code have only RO support. Prepare RW acces for tar nball
    file structure will not be so trivial.
2) If You want save disk space for small files with also RO access
    only better will be spend some time on romfs for extend them for allow
    operate on slightly bigger file systeme than curreent lmitation this fs.
    Packing to tar file will be functionaly equal to generate romfs image
    using genromfs.
3) Maybe I'm wrong but IIRC raiserfs have block suballocation. If I'm
    wrong (about current raiserfs) btter will be write and use some fs with
    this kind feacture.
4) Huge or very huge amout of small files it is usulaly case on filesystem
    for mail spool. It need RW access. Subject was many tilme in past
    discussed and can be find on archives aroud mailfs or mailstorfs
    words. Tar ball structure isn't specialized for allow fast RW operation.
    In cases where speed isn't issue tarfs will be fuctional equivalet to romfs.

Count of cases where tarfs will be useable will be probably very close to 
cout of cases where romfs is used now. All without add single line of code 
on kernel level :-)

tarfs it is *good* code example but IMO .. only example :_)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-611903269-1099835345=:21903--
