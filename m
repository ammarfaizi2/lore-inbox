Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265939AbUEUWYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUEUWYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUEUWYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:24:16 -0400
Received: from [213.171.41.46] ([213.171.41.46]:50437 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S265939AbUEUWYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:24:12 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
Organization: MySQL AB
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Spam: Re: Random file I/O regressions in 2.6 [patch+results]
Date: Sat, 22 May 2004 02:24:08 +0400
User-Agent: KMail/1.6.2
Cc: Jens Axboe <axboe@suse.de>, nickpiggin@yahoo.com.au, linuxram@us.ibm.com,
       peter@mysql.com, linux-kernel@vger.kernel.org
References: <200405022357.59415.alexeyk@mysql.com> <20040521075027.GN1952@suse.de> <20040521015647.4c383868.akpm@osdl.org>
In-Reply-To: <20040521015647.4c383868.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405220224.08453.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2004 12:56, Andrew Morton wrote:
>
>What I need is a way of getting sysbench to create and remove the database
>files in separate invokations, but the syntax for that is defeating me at
>present.
>

I have changed the syntax to allow creating/removing test files and test 
running in separate stages:

sysbench --test=fileio --file-total-size=3G prepare

sysbench --num-threads=16 --test=fileio --file-total-size=3G  
--file-test-mode=rndrw run

sysbench --test=fileio cleanup

The updated version is available from the SysBench page at 
http://sourceforge.net/projects/sysbench/

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
