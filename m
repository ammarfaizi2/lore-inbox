Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUH0L7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUH0L7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 07:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUH0L7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 07:59:08 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:19716 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263743AbUH0L7F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 07:59:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Gergely Tamas <dice@mfa.kfki.hu>, linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
Date: Fri, 27 Aug 2004 14:55:03 +0300
X-Mailer: KMail [version 1.4]
Cc: akpm@osdl.org
References: <20040827105543.GA10563@mfa.kfki.hu>
In-Reply-To: <20040827105543.GA10563@mfa.kfki.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408271455.03733.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 13:55, Gergely Tamas wrote:
> Hi!
>
> I've hit the following data loss problem under 2.6.9-rc1-mm1.
>
> If I copy data from a file to another the target will be smaller then
> the source file.
>
> 2.6.9-rc1 does not have this problem
> 2.6.8.1-mm4 does not have this problem
> 2.6.9-rc1-mm1 _does have_ this problem

I've seen some errors from KDE too. Let me do your test...

# dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
10+0 records in
10+0 records out
# cat testfile > testfile.1
# ls -l test*
-rw-r--r--    1 root     root     10485760 Aug 27 14:53 testfile
-rw-r--r--    1 root     root     10481664 Aug 27 14:53 testfile.1

-- 
vda
