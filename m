Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262440AbSJDQ3i>; Fri, 4 Oct 2002 12:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262439AbSJDQ3f>; Fri, 4 Oct 2002 12:29:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29843 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262434AbSJDQ3a>;
	Fri, 4 Oct 2002 12:29:30 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF2060727F.1EF82AFF-ON85256C48.0059BC95@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Fri, 4 Oct 2002 11:40:45 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/04/2002 12:34:25 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/04/2002 at 11:00 AM, Matthew Wilcox wrote:

> That behaviour for list_del is new and, IMNSHO, bogus.  There's now
_zero_
> gain in using list_del instead of list_del_init.

The only gain I've noticed is when the container
object is memset it gives implicit initialization
if one uses list_del.

> akpm changed it about
> 5 months ago with a comment that says:

> "list_head debugging"

> so i think it's pretty safe to assume that this behaviour will not
> remain into 2.6.  if you think you want list_member, use list_del_init
> and list_empty() instead.

I wasn't aware this was somewhat recently added item
for debug and will switch to list_del_init().

Thanks for bring this to my attention!


