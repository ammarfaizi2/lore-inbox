Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWAUBih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWAUBih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWAUBih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:38:37 -0500
Received: from web34114.mail.mud.yahoo.com ([66.163.178.112]:60088 "HELO
	web34114.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964831AbWAUBig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:38:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XiZegjoVwoPWWIXjC6TCifSia8m1FGyE335cVKVU4EyUZ6POpCrOsMjHs22lflWywoA8AF06WEUc5NKi/XIeRkZ1oQcOfK+pbOTu4vm+q+wpGNzzELOEd5ItXAkwkgGrE28SzHlU4kfWpohZGQmWs5FSAPd5ap93yuwzbB05OmY=  ;
Message-ID: <20060121013835.24035.qmail@web34114.mail.mud.yahoo.com>
Date: Fri, 20 Jan 2006 17:38:35 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: set_bit() is broken on i386?
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it not be more correct to have "+m" to show that the register is both an input and an
output, and nothing more?
Or is set_bit supposed to be a general barrier or fence?

static inline void set_bit(int nr, volatile unsigned long * addr)
{
	__asm__ __volatile__( "lock ; "
		"btsl %1,%0"
		:"+m" (ADDR)
		:"Ir" (nr));
}

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
