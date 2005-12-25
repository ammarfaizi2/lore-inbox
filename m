Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVLYJ3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVLYJ3H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 04:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLYJ3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 04:29:07 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:55671 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750805AbVLYJ3G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 04:29:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gNpbysvB+RvVuQYyBqKPBgq46l5DRsz9uwS8BDMNAVp6e6cCdQIWL9Gj6D/ndCdypPpWWN72LzUdspTH31BV3cEYeOkiIDIxw2kDLXDzwAPKFS77e6UY/4PyNBlCSXyGgFelTYGxYKvzVIXwd5qRKNaazCjXlboqAOS2i6CrYd4=
Message-ID: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com>
Date: Sun, 25 Dec 2005 12:29:05 +0300
From: regatta <regatta@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: FS possible security exposure ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have a question regarding how Linux handle the files permission ,
here is what I found

When logged on to a Linux workstation a user can edit a file (even if
the file on an NFS-mounted NAS directory) if he has write access at
the directory level, even if the file is owned by root (or any other
user) and is read-only.

I tried this in local file system (ext3) and in remote home directory
(autofs) in (NetApp nfs NAS storage)

this is not the case with Solaris , the user will get permission
denied if he try to write any thing to the file.


My question is, what is happening ? and is it correct ? is it possible
to change it to behave to be like Solaris ?

(when you have hundred of users and hundred of NFS and thousand of 
net groups you don't want a user to edit other file just because he
has write permission in the patent dir).

Thanks

Best Regards,
--------------------
-*- If Linux doesn't have the solution, you have the wrong problem -*-
