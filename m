Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbSJHKhT>; Tue, 8 Oct 2002 06:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbSJHKhT>; Tue, 8 Oct 2002 06:37:19 -0400
Received: from aneto.able.es ([212.97.163.22]:52987 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id <S261810AbSJHKhS>;
	Tue, 8 Oct 2002 06:37:18 -0400
Date: Tue, 8 Oct 2002 12:42:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021008104244.GA1895@werewolf.able.es>
References: <1034044736.29463.318.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1034044736.29463.318.camel@phantasy>; from rml@tech9.net on Tue, Oct 08, 2002 at 04:38:55 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2002.10.08 Robert Love wrote:
>Attached patch implements an O_STREAMING file I/O flag which enables
>manual drop-behind of pages.
>
>If the file has O_STREAMING set then the user has explicitly said "this
>is streaming data, I know I will not revisit this, do not cache
>anything".  So we drop pages from the pagecache before our current
>index.  We have to fiddle a bit to get writes working since we do
>write-behind but the logic is there and it works.
>

Sorry if this is a newbie question, but, does glibc pass flags blindly
to the syscal ?? Ie, I do not need to rebuild glibc to use this in
open(), fcntl() and so on, just I can make sure that bit 04000000
is set in the flags.

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre9-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
