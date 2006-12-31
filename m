Return-Path: <linux-kernel-owner+w=401wt.eu-S1030301AbWLaRNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWLaRNx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWLaRNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:13:53 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:44478 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030301AbWLaRNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:13:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EJHq1wghEutLygsruOcQmS1WFQk3xrhQhlC55ElqTbu2eszTKLcU6qpBnQfLoewO8P2rvUJ/bOn40oaUdaEmov5xvMNFXHQDIS8CAOtAaAo0Kdf+4Q/vq0YhcS1vhm8npmHrXz/ZTs9Yar29ecnGTjWANb03l755x5nzeMWLbvA=
Message-ID: <9e4733910612310913v191b519fpa179bfc56f140baf@mail.gmail.com>
Date: Sun, 31 Dec 2006 12:13:52 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Using _syscall3 to manipulate files in a driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the source code for a vendor written driver that is targeted at
2.6.9. It includes this and then proceeds to manipulate files from the
driver.

asmlinkage _syscall3(int,write,int,fd,const char *,buf,off_t,count)
asmlinkage _syscall3(int,read,int,fd,char *,buf,off_t,count)
asmlinkage _syscall3(int,open,const char *,file,int,flag,int,mode)
asmlinkage _syscall1(int,close,int,fd)

What is the simplest way to get open/close/read/write working under
2.6.20-rc2? I know this is horrible and shouldn't be done, I just want
to get the driver working long enough to see if it is worth saving.
I'm on x86.

-- 
Jon Smirl
jonsmirl@gmail.com
