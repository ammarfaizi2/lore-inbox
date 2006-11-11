Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424596AbWKKSLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424596AbWKKSLn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbWKKSLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:11:43 -0500
Received: from web27415.mail.ukl.yahoo.com ([217.146.177.191]:1684 "HELO
	web27415.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1754860AbWKKSLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:11:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BIoItPRWLeT8vaU+M3aD10o6+Ze1U3+ajbjYuxcrpy8WmaUPLMVYsIrDTygBa85hnPFr+Tu4t8O+vkaJheo0dKUO8no09nAy6MF2CJrfTbEA9B05Pc7GmyMSqSv9oGfDFGTNZeovKde7ck0UoNUttXYf3IdFVjaAPrg2v7UMSbw=  ;
Message-ID: <20061111181141.86824.qmail@web27415.mail.ukl.yahoo.com>
Date: Sat, 11 Nov 2006 18:11:41 +0000 (GMT)
From: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Subject: printk in user mode program
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got compilation errors when I compiled the below
program by the command "gcc 1.c". 

Note: I inluded printk instead of printf because I
have to call the executable code, produced by
compiling the below code, in a kernel module using
call_usermodehelper().

 Please help me.
Thanks in advance.

---------------------------------------------
#include<stdio.h>
#include<linux/module.h>
#include<linux/kernel.h>
int main(int argc,char **argvp,char **envp)
{
int a,b,c,d;
for(a=0;a<99999;a++)
for(d=0;d<9;d++)
//for(b=0;b<9999;b++)
c++;
printk(KERN_INFO "USER PROGRAM \n");

return 0;

}
-------------------------------------------------
compilation errors:

1.c: In function `main':
1.c:11: error: `KERN_INFO' undeclared (first use in
this function)
1.c:11: error: (Each undeclared identifier is reported
only once
1.c:11: error: for each function it appears in.)
1.c:11: error: syntax error before string constant


Send instant messages to your online friends http://uk.messenger.yahoo.com 
