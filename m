Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbUBAOvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 09:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265321AbUBAOvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 09:51:35 -0500
Received: from 213-84-216-119.adsl.xs4all.nl ([213.84.216.119]:44180 "EHLO
	morannon.frodo.local") by vger.kernel.org with ESMTP
	id S265320AbUBAOvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 09:51:32 -0500
From: Frodo Looijaard <frodol@dds.nl>
Date: Sun, 1 Feb 2004 15:51:11 +0100
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       linux-7110-psion@lists.sourceforge.net, Andries.Brouwer@cwi.nl
Subject: Re: PATCH to access old-style FAT fs
Message-ID: <20040201145110.GA8586@frodo.local>
References: <20040126173949.GA788@frodo.local> <bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp> <4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp> <20040128115655.GA696@arda.frodo.local> <87y8rr7s5b.fsf@devron.myhome.or.jp> <20040128202443.GA9246@frodo.local> <87bron7ppd.fsf@devron.myhome.or.jp> <20040129223944.GA673@frodo.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20040129223944.GA673@frodo.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

another update of the patch, which addresses some of the reactions and 
concerns which I got in reply:

  * The mount option is now called `epoc' instead of `oldfat'
  * fat_search_long now jumps directly to EODir when it finds a
    zero-marked entry (it took some hard looking, but I belief this
    is safe).
  * fat_readdirx logic is slightly simplified (but can't jump to EODir
    on a zero-marked entry, regrettably).

Thanks for your feedback!

I'll try to keep this patch up-to-date with new 2.6 kernels. The latest
version can always be found on http://debian.frodo.looijaard.name/

Thanks,
  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

--AhhlLboLdkugWU4S
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="linux-fat-epoc-2.6.0.patch-20040201.gz"
Content-Transfer-Encoding: base64

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

--AhhlLboLdkugWU4S--
