Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265707AbUAKB53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 20:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265708AbUAKB53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 20:57:29 -0500
Received: from ms-smtp-03-qfe0.nyroc.rr.com ([24.24.2.57]:13245 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S265707AbUAKB51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 20:57:27 -0500
Date: Sat, 10 Jan 2004 20:57:24 -0500
To: linux-kernel@vger.kernel.org
Subject: personality.h: struct map_segment
Message-ID: <20040111015723.GA8968@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/personality.h defines

struct exec_domain {
        const char              *name;          /* name of the execdomain */
        handler_t               handler;        /* handler for syscalls */
        unsigned char           pers_low;       /* lowest personality */
        unsigned char           pers_high;      /* highest personality */
        unsigned long           *signal_map;    /* signal mapping */
        unsigned long           *signal_invmap; /* reverse signal mapping */
        struct map_segment      *err_map;       /* error mapping */
        struct map_segment      *socktype_map;  /* socket type mapping */
        struct map_segment      *sockopt_map;   /* socket option mapping */
        struct map_segment      *af_map;        /* address family mapping */
        struct module           *module;        /* module context of the ed. */
        struct exec_domain      *next;          /* linked list (internal) */
};

However, as best as I can tell, struct map_segment is never defined.
I've grepped 2.4 and 2.5, and googled to no avail.  I'm just curious, is
this simply unimplemented functionality?  And what is it ultimately
supposed to do?

Justin
