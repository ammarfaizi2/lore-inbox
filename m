Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262644AbTCIWSl>; Sun, 9 Mar 2003 17:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbTCIWSl>; Sun, 9 Mar 2003 17:18:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:53442 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262644AbTCIWSk>;
	Sun, 9 Mar 2003 17:18:40 -0500
Date: Sun, 9 Mar 2003 14:29:42 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in ext3 error handling -> journal_abort
Message-Id: <20030309142942.02cfce5d.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0303091704330.1464-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303091704330.1464-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2003 22:29:09.0824 (UTC) FILETIME=[4DB36400:01C2E68B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> I managed to get this when mounting a corrupt volume, it looks like my 
> journal got zapped. Andrew would a couple extra checks for 
> EXT3_SB(sb)->s_journal be ok during fill_super?
> 

It might be that ext3_handle_error() is the only place which needs the test.
I'll check it over, thanks.
