Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTE2UuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTE2UuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:50:12 -0400
Received: from minmail.no ([213.160.234.15]:33506 "EHLO new.minmail.no")
	by vger.kernel.org with ESMTP id S262714AbTE2UuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:50:11 -0400
From: Morten Helgesen <morten.helgesen@nextframe.net>
Reply-To: morten.helgesen@nextframe.net
Organization: Nextframe AS
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: list_head debugging patch
Date: Thu, 29 May 2003 23:03:19 +0200
User-Agent: KMail/1.5
References: <20030529130807.GH19818@holomorphy.com> <200305292158.52311.morten.helgesen@nextframe.net> <20030529201337.GC8978@holomorphy.com>
In-Reply-To: <20030529201337.GC8978@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305292303.19946.morten.helgesen@nextframe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 22:13, William Lee Irwin III wrote:
> On Thu, May 29, 2003 at 09:58:52PM +0200, Morten Helgesen wrote:
> > one more ...
> > elem = c3a6464c, elem->prev = c11d59e8, elem->prev->next =
> > c28cc1ec ------------[ cut here ]------------
> > kernel BUG at include/linux/list.h:39!
> > invalid operand: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[<c016b21c>]    Not tainted
> > EFLAGS: 00010286
> > EIP is at file_kill+0x2c/0x150
>
> Same thing; nuke the __list_head_check() check in list_empty()
> please.

Ok, after having nuked __list_head_check() in list_empty() I can`t 
seem to trigger any more list corruption on this box.

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
morten.helgesen@nextframe.net / 93445641
http://www.nextframe.net

