Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289013AbSAFTdt>; Sun, 6 Jan 2002 14:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSAFTd3>; Sun, 6 Jan 2002 14:33:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40965 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289013AbSAFTdX>; Sun, 6 Jan 2002 14:33:23 -0500
Subject: Re: [PATCH] C undefined behavior fix
To: guerby@acm.org (Laurent Guerby)
Date: Sun, 6 Jan 2002 19:43:43 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
In-Reply-To: <3C38A526.2050309@acm.org> from "Laurent Guerby" at Jan 06, 2002 08:27:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NJCp-0006Jj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't done my homework, but I assume the code behind readb use inline
> assembly and not C on most platforms?

It depends on the platform. Its all nicely wrapped in platform specific
macros and using things like volatile to get the right results. Whatever
gcc invents we can cope with for a weird port because we can make them asm
