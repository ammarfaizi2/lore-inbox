Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262401AbSI2GYm>; Sun, 29 Sep 2002 02:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262403AbSI2GYm>; Sun, 29 Sep 2002 02:24:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2211 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262401AbSI2GYl>;
	Sun, 29 Sep 2002 02:24:41 -0400
Date: Sat, 28 Sep 2002 23:23:26 -0700 (PDT)
Message-Id: <20020928.232326.43409659.davem@redhat.com>
To: arvind_gopalan@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4 byte mem alignment
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020929062646.97364.qmail@web14606.mail.yahoo.com>
References: <20020929062646.97364.qmail@web14606.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arvind Gopalan <arvind_gopalan@yahoo.com>
   Date: Sat, 28 Sep 2002 23:26:46 -0700 (PDT)

   how strong the requirements are for copy_to_user().
   does it fault to byte-by-byte mode gracefully when
   given a non-4byte aligned buffer?.

The x86 processor handles unaligned memory accesses in hw.

On any platform, copy_to_user() must handle any user and kernel buffer
alignment.
