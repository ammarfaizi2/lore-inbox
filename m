Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTACXOn>; Fri, 3 Jan 2003 18:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267713AbTACXOn>; Fri, 3 Jan 2003 18:14:43 -0500
Received: from mx0.gmx.de ([213.165.64.100]:54373 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S267699AbTACXOm>;
	Fri, 3 Jan 2003 18:14:42 -0500
Date: Sat, 4 Jan 2003 00:23:08 +0100 (MET)
From: Jan Schiefer <CHEATERJS@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Kernel bug in agpgart module!
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008108751@gmx.net
X-Authenticated-IP: [212.202.169.137]
Message-ID: <3590.1041636188@www15.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a bug in agpgart module, that isn't fixed in any version. Even not
development releases.

Description:
Mainboard: VIA K7VZA KT133 Chipset (Via Apollo Pro KT133)
When AGP APARTURE SIZE 4M is set in BIOS, then agpgart cant bind the port to
the graphic card module. DRI and stuff don't work. It seems to work with
anything bigger than 4M.

This isn't passed:
agpgart_be.c

---
static int agp_generic_insert_memory(agp_memory * mem,
				     off_t pg_start, int type)
{

(...blah...)

	if ((pg_start + mem->page_count) > num_entries) {  //<--- This check fails
then! :O
	return -EINVAL;
	}
	
---

Maybe someone can fix it. (I'm an windowze only coder. :( )

Greetings,
Jan Schiefer!

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!

