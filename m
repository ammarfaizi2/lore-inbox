Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUHAAWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUHAAWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUHAAWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:22:37 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:47912 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263159AbUHAAWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:22:36 -0400
Message-ID: <410C37B7.3010504@zensonic.dk>
Date: Sun, 01 Aug 2004 02:22:15 +0200
From: "Thomas S. Iversen" <zensonic@zensonic.dk>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to do IO across hardsector boundries
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There

As part of an assignment I am trying to port a piece of software from 
FreeBSD to linux. Essentially this software (crypto) makes a virtual 
blockdevice with "virtual" sectors on top. Under FreeBSD these virtual 
sectors are just read/written using a simple command:

buf=g_read(dev, offset, len)
error=g_write(dev,offset,buf,len)

In linux however I have only seen the BIO layer which operates on IO on 
hardsector boundaries.

So my question really is, how do I go about updating for instance the 
512 bytes located for at byte 64 to 64+511 on the actual media without 
getting in trouble regarding the data from offset 0-63 and 64+512->1023?

Regards Thomas
