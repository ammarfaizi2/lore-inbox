Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUHZN4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUHZN4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268881AbUHZN4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:56:53 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:62094 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268849AbUHZN43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:56:29 -0400
Date: Thu, 26 Aug 2004 15:59:24 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1714037053.20040826155924@tnonline.net>
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.44.0408260938340.26316-100000@chimarrao.boston.redhat.com>
References: <1453776111.20040826131547@tnonline.net>
 <Pine.LNX.4.44.0408260938340.26316-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thu, 26 Aug 2004, Spam wrote:

>>   Yes, JPEG, TIFF and PNG files for example. But, if you modify any of
>>   these  with  an application that doesn't support the extensions then
>>   you will loose them.

> OK, so we've got a choice.

> Either we will lose the extensions when modifying the file
> with an unaware program, or you lose the extensions when
> copying (or restoring from backup) using an unaware program.

> Personally I'd prefer to keep the file intact when not
> modifying it...

  Backup to me is a special case, not simply a copy of files, but also
  retaining all the extra data, info, attributes, etc, that comes with
  the file.

  Enabling  support  to  have  all  of  this  extra  stuff  below  the
  application  level  it  will  be  possible to retain everything even
  though applications do not support them.

  Backup tools, however, must know about these new features to be able
  to  backup  them.  And so will every tool that directly accesses the
  filesystem instead of using the OS API for it.

  And  from  I  learned  in an earlier message, tools like cp actually
  work  on  the  fs level and themselves move the data to the new file
  instead   of  letting  the OS handle it. This seem to me as it could
  be  dangerous and could also prevent any kind of enhancements to the
  FS unless every tool like cp is patched.
  





