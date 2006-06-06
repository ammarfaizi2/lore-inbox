Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWFFNeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWFFNeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWFFNeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:34:16 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:51645 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932158AbWFFNeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:34:15 -0400
Subject: Re: [PATCH] poison: add & use more constants
From: Steven Rostedt <rostedt@goodmis.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: davej@redhat.com, mingo@elte.hu, mbligh@google.com, akpm@osdl.org,
       apw@shadowen.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060605135401.f7941311.rdunlap@xenotime.net>
References: <44845C27.3000006@google.com> <20060605194422.GB14709@elte.hu>
	 <20060605130039.db1ac80c.rdunlap@xenotime.net>
	 <20060605200554.GB6143@redhat.com>
	 <20060605131447.4f46bbaf.rdunlap@xenotime.net>
	 <20060605135401.f7941311.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 09:33:58 -0400
Message-Id: <1149600838.16247.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 13:54 -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Add more poison values to include/linux/poison.h.
> It's not clear to me whether some others should be added or not,
> so I haven't added any of these:
> 
> ./include/linux/libata.h:#define ATA_TAG_POISON		0xfafbfcfdU
> ./arch/ppc/8260_io/fcc_enet.c:1918:	memset((char *)(&(immap->im_dprambase[(mem_addr+64)])), 0x88, 32);
> ./drivers/usb/mon/mon_text.c:429:	memset(mem, 0xe5, sizeof(struct mon_event_text));
> ./drivers/char/ftape/lowlevel/ftape-ctl.c:738:		memset(ft_buffer[i]->address, 0xAA, FT_BUFF_SIZE);
> ./drivers/block/sx8.c:/* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */

You don't have my personal favorite?  From AIX that would poison pages
with 0xdeadbeef  :)

-- Steve


