Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVCUI36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVCUI36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVCUI36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:29:58 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:44431 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261686AbVCUI30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:29:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=G5opl5Idxw2IQpBuWbDjMlWFq0JFrRD5S2C/D9y/WoeP2yFswABDWFU7YIRTJcEmmD1UCZ5A5PHRG3BfJc90Nf0dTwaB7kZ3hyjDGAbQtTpTjBhM2xNRfC6AEYkbQBDhcGjX38PkCeT7WU7+ihJVlMpaInPL+VB7dm1pWoD/ZRU=
Message-ID: <4ae3c1405032100293ff52077@mail.gmail.com>
Date: Mon, 21 Mar 2005 03:29:21 -0500
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why is NFS write so slow?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the dumb question. 

I am trying to develop a new filesystem based on NFS, which runs in a
very fast network environment. I used the source code of NFS2, but
noticed that NFS write is very slow. Even if I changed wsize to 8192,
it still can only reach 1MB/s. I don't know why. Because the network
is extremely fast (over 100MB/s), I don't think network is the only
reason. Any other reason?

Is the NFS write synchronous? Does that means the NFS server will not
return before the data is flushed to disk?  Because nfsd_write will
close the file every time, I will assume that the data will be flushed
to disk before return. However, even if I change nfsd_write to stop
closing file, the write speed is still very slow. Can someone give me
some advice about this?

Thanks in advance!

-x
