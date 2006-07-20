Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWGTV0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWGTV0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 17:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWGTV0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 17:26:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:19147 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030379AbWGTV0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 17:26:54 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
To: Pekka J Enberg <penberg@cs.Helsinki.FI>, alan@lxorguk.ukuu.org.uk,
       tytso@mit.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 20 Jul 2006 23:26:01 +0200
References: <6AFvY-7ZK-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G3g2H-0001W7-LB@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> From: Pekka Enberg <penberg@cs.helsinki.fi>

> This patch implements the revoke(2) and frevoke(2) system calls for all
> types of files. We revoke files in two passes: first we scan all open
> files that refer to the inode and substitute the struct file pointer in fd
> table with NULL causing all subsequent operations on that fd to fail.
> After we have done that to all file descriptors, we close the files and
> take down mmaps.

RFC2: Make umount -f work on local fs using this feature.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
