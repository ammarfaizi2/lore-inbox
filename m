Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUGUSjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUGUSjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUGUSjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:39:00 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:62448 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S266578AbUGUSiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:38:50 -0400
Message-ID: <40FEB7B8.2050501@inostor.com>
Date: Wed, 21 Jul 2004 11:36:40 -0700
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: What is the BUG() call in ll_rw_blk.c (2.4.26) for?
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

void submit_bh(int rw, struct buffer_head * bh)
{
~        int count = bh->b_size >> 9;


~        if (!test_bit(BH_Lock, &bh->b_state))
~                BUG();

Does anyone know what that BUG(); is testing? We're seeing it and want
to track down what we're doing that is causing it.

It's at line 1289 of drivers/block/ll_rw_blk.c

Thanks!

- -Tom

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFA/re42dxAfYNwANIRAsM2AKCZK64SB8H3ypeOp6r9srECt8lSEgCfeyya
amEarqisYBF6MocYu6m/Nbo=
=HZZk
-----END PGP SIGNATURE-----
