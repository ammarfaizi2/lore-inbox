Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276364AbRJCPVD>; Wed, 3 Oct 2001 11:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276370AbRJCPUy>; Wed, 3 Oct 2001 11:20:54 -0400
Received: from mail1.panix.com ([166.84.0.212]:31487 "HELO mail1.panix.com")
	by vger.kernel.org with SMTP id <S276364AbRJCPUr>;
	Wed, 3 Oct 2001 11:20:47 -0400
From: "Roy Murphy" <murphy@panix.com>
Reply-To: murphy@panix.com
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Oct 2001 11:21:16 -0500
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
X-Mailer: DMailWeb Web to Mail Gateway 2.6k, http://netwinsite.com/top_mail.htm
Message-id: <3bbb2cec.6d.0@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Twas brillig when Sebastien Cabaniols scrobe:
>With the availability of XFS,JFS,ext3 and ReiserFS I am a 
>little lost and I don't know which one I should use for entreprise 
>class servers. 

Well, the Linus Torvalds filesystem (ltfs for short) is a highly developed,
version control filesystem, but it still has a few shortcomings.

When saving a file to ltfs, it sometimes suggests that you should do it a different
way.  The ltfs is very particular about how things should be done.

Often, when saving a file, it is dropped without any notification.  Experienced
users of the ltfs follow the mantra "submit early and submit often".  They repeatedly
resave their files hoping that one of them will be accepted into a "version"
that does get saved to disk.

Several forks of the ltfs (i.e the Alan Cox filesystem -- acfs and the Anread
Arcangeli filesystem -- aafs) are a little better about saving files, but each
of them has its own idea about which files are worthy of being saved.

While these advanced filesystems hold great promise for the future, they should
probably not be used in a production server due to these failings.  In fact,
one user of the acfs, Telsa Cox, reports that the acfs often dosn't work at
all before noon local time.

YMMV.
 
