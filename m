Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263768AbREYPYp>; Fri, 25 May 2001 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263766AbREYPYf>; Fri, 25 May 2001 11:24:35 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:59744 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S263765AbREYPYc>; Fri, 25 May 2001 11:24:32 -0400
Message-ID: <3B0EE8CF.7040502@niisi.msk.ru>
Date: Fri, 25 May 2001 19:20:47 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Disabling interrupts before block device request call
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, list
In ll_rw_block.c, before calling block device specific request function 
( i mean do_hd_request, do_ftl_request, ... ) the io_request_lock is 
locking, and all interrupts are disabling. I know, that request handler 
routine have to be atomic, but when we read data from a flash device ( 
for example ) we use a timeouts. Where do we have to enable timer 
interrupts, or should we disable all interrupts?

