Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbTBBOkw>; Sun, 2 Feb 2003 09:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTBBOkw>; Sun, 2 Feb 2003 09:40:52 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:6813 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S265320AbTBBOkv>; Sun, 2 Feb 2003 09:40:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: shaheed <srhaque@iee.org>
To: Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] NFS dev_t fixes
Date: Sun, 2 Feb 2003 14:53:06 +0000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302021453.06531.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries,

Just a thought...did you intend to use two slightly different types for 
major/minor? You say in nfs3xdr.c:

xdr_decode_fattr(u32 *p, struct nfs_fattr *fattr) 
 { 
...
	unsigned int type, major, minor; 
...
 	major = ntohl(*p++); 
	minor = ntohl(*p++); 

and later on in nfs4xdr.c:

	uint32_t major, minor; 
...
	READ32(major); 
	READ32(minor); 

I wonder if the real cause here is the different coding conventions of the two 
modules...

HTH, Shaheed
