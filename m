Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbVKQFfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbVKQFfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 00:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbVKQFfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 00:35:46 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:1993 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161139AbVKQFfq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 00:35:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FPgtzguL+8OX/grG3tqgLX+089oNRBzqtyXu8SuwhOL0QHIDmpY7XNnJUflT4rWTEzAo4mWmwLIKqh4I+FKlz3Wki7o5TPKgIwLiZvpazbWQT30eJSztSRdDfKBln8ukHpRy6Ub98GInXoxsAjV7Y7ojdbNBtLQmQyBpd3e6sj8=
Message-ID: <4ae3c140511162135j7a72299eg8223dfedab8eea62@mail.gmail.com>
Date: Thu, 17 Nov 2005 00:35:43 -0500
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: nfs3 implementation issue?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In nfs/nfs3proc.c: nfs3_read_done(), I saw the following line:

   struct nfs_write_data *data = (struct nfs_write_data *) task->tk_calldata;

I don't know why the tk_calldata is regarded as nfs_write_data instead
of nfs_read_data. When this rpc call is set up, we put
task->tk_calldata as a nfs_read_data object, why will it become a
nfs_write_data after the rpc call is done?

Can someone explain this a little bit?

Thanks!

Xin
