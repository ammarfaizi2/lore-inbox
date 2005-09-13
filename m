Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVIMOHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVIMOHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVIMOHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:07:43 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:31422 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750814AbVIMOHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:07:43 -0400
From: "ext3crypt" <ext3crypt@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: Input Desired -- sorry if this is not the forum.
Date: Tue, 13 Sep 2005 10:07:41 -0400
Message-ID: <PFEILFFLMPNHAOBNBGPJIEFGCAAA.ext3crypt@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently working on a kernel modification to extend the EXT3 file
system to include encryption based on file ownership.

This is an experimental graduate project for Penn State that may result in a
proposed patch.

Each user and group has an encryption key and files are encrypted with
the key based on permissions.  The issues is what should I do about
"root" access, since root has free access to everything.  There are two
goals -- transparency (everything works like it did without encryption but
slower)
and security (for root it conflicts with transparency).

I can maintain free access -- but the overall security is weakened
since an attacker will only need to gain the root encryption key to
authenticate.

I can disallow access to files for root based on the permissions --
which may cause applications to stop working properly, since they may
count on root's special privlages.

I can allow access to files that are encrypted and root does not have
permissions to as ciphertext and the files root does have access to as
plaintext.

Other ideas are welcome.


