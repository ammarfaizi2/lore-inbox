Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbTBQPqE>; Mon, 17 Feb 2003 10:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTBQPqE>; Mon, 17 Feb 2003 10:46:04 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:44805
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265865AbTBQPqE>; Mon, 17 Feb 2003 10:46:04 -0500
Subject: Re: Performance of ext3 on large systems
From: Robert Love <rml@tech9.net>
To: John Bradford <john@grabjohn.com>
Cc: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200302171529.h1HFTVPk010325@darkstar.example.net>
References: <200302171529.h1HFTVPk010325@darkstar.example.net>
Content-Type: text/plain
Organization: 
Message-Id: <1045497374.12615.1.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.0.99 (Preview Release)
Date: 17 Feb 2003 10:56:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-17 at 10:29, John Bradford wrote:

> > ext3 doesn't implement noatime!?  Hurg...

noatime is implemented.

> Actually, it makes sense in a way - noatime only speeds up reads, not
> writes, (access time is always updated on a write), whereas a
> journaled filesystem is presumably intended to be tuned for write
> performance.  So, for it's intended usage, not implementing noatime
> shouldn't be a huge problem, although it would be useful.

But updating the access time _is_ a write, even if its due to a read. 
And using 'noatime' does help, and it is implemented.  I guess Andrew's
statement was just misinterpreted, because this is what he said.

	Robert Love

