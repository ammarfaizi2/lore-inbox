Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTAJKaX>; Fri, 10 Jan 2003 05:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTAJKaX>; Fri, 10 Jan 2003 05:30:23 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:43514 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264857AbTAJKaW>; Fri, 10 Jan 2003 05:30:22 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty
References: <20030110073328.D41A52C310@lists.samba.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 10 Jan 2003 19:39:03 +0900
In-Reply-To: <20030110073328.D41A52C310@lists.samba.org>
Message-ID: <buor8bl8f20.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, I noticed that there's actually a bug in my patch -- it assumes
the length of MODULE_SYMBOL_PREFIX is 1.  So change:

        char sym_name[strlen(obsparm[i].name) + 2];

to:

        char sym_name[strlen(obsparm[i].name) + sizeof MODULE_SYMBOL_PREFIX];

-Miles
-- 
Would you like fries with that?
