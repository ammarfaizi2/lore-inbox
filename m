Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVCOG6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVCOG6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVCOG6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:58:20 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:20997 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262286AbVCOG6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:58:17 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Alexander Gran <alex@zodiac.dnsalias.org>,
       "E.Gryaznova" <grev@namesys.com>
Subject: Re: Fw: 2.6.11-rc5-mm1: reiser4 eating cpu time
Date: Tue, 15 Mar 2005 08:57:36 +0200
User-Agent: KMail/1.5.4
Cc: reiserfs-dev <reiserfs-dev@namesys.com>, linux-kernel@vger.kernel.org
References: <20050303184456.534aedb6.akpm@osdl.org> <4230582F.2050503@namesys.com> <200503131424.33498@zodiac.zodiac.dnsalias.org>
In-Reply-To: <200503131424.33498@zodiac.zodiac.dnsalias.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503150857.37419.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 March 2005 15:24, Alexander Gran wrote:
> Hi, 
> 
> Well, of course it cannot handle that large files (I wouldn't expect that, 
> either). My Problem is that when I open the file, it's not just kwrite but 
> other processes that need so much cpu time. That kwrite is eating cpu is ok. 
> I cannot reproduce the behaviour for some reason however. 
> So for short what's now (2.6.11-mm3) hapening:
> I open a file of 150MB with kwrite. Kwrite start using all cpu it can get
> After some seconds pdflush kicks in. Kwrite seems to wait, and pdflush is 
> eating cpu cyles. These 2 alternate for some time, until file is loaded. 

I bet kwrite does something silly.

Use strace -tt to find out whether kwrite spends that much CPU
by doing zillions of syscalls or not. 
--
vda

