Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVJKN7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVJKN7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVJKN7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:59:49 -0400
Received: from web8402.mail.in.yahoo.com ([202.43.219.150]:45720 "HELO
	web8402.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932099AbVJKN7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:59:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YmcPwqU6a7BerFCGo0fgbCWlRzn17GOvxGumR7e4bmZ2Uer4BQuzd3nLE/2+1IyMRmvyihifsI5zgsOd5sP0FTnv92HV/XLTp777k1CVL02EnOfJcmIM4IEnUrYYiNfz8oqnsHe1/ENSitHlpGDkaXTV4HGlqdqD1ah2xQkFuoM=  ;
Message-ID: <20051011135944.22612.qmail@web8402.mail.in.yahoo.com>
Date: Tue, 11 Oct 2005 14:59:44 +0100 (BST)
From: vinay hegde <thisismevinay@yahoo.co.in>
Subject: Regarding - unresolved symbol
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I am developing a device driver module related to the
real time clock on Linux 2.4 kernel. [This is done
with regard to changing one of the existing timer chip
on the  system.] For some reason, I am getting into an
unresolved symbol.

I am following sequence of code in the module (not
necessarily in the sequential manner though).

----------
extern void *sys_call_table[];
static int (*timer_mknod)(const char *, ... ); 
timer_mknod = sys_call_table[__NR_mknod];
----------

Whenever I try to insert the module into the kernel, I
get the following error:
timer.o: unresolved symbol sys_call_table

All the necessary headers are present and I am able to
see the symbol 'sys_call_table' in System.map. I do
not see any error in this regard. Can somebody help me
in pointing out the flaw? 

[I am able to fix this problem by simply using the
'sys_mknod()' call in my module, but I really would
like to know why the above piece of code can not
work!]

Thank you,
Vinay Hegde


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
