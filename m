Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbTACXXK>; Fri, 3 Jan 2003 18:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTACXXK>; Fri, 3 Jan 2003 18:23:10 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:25202 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267713AbTACXXJ> convert rfc822-to-8bit; Fri, 3 Jan 2003 18:23:09 -0500
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A1508E438@orsmsx106.jf.intel.com>
From: "Shureih, Tariq" <tariq.shureih@intel.com>
To: "'Jan Schiefer'" <CHEATERJS@gmx.de>, linux-kernel@vger.kernel.org
Subject: RE: Kernel bug in agpgart module!
Date: Fri, 3 Jan 2003 15:31:29 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WindowZ programmers can't write Linux code?  It's C after all :p

Maybe it's a licensing thingie?! :=)

--
Tariq Shureih
Intel Corporation
Opinions are my own and don't represent my employer

-----Original Message-----
From: Jan Schiefer [mailto:CHEATERJS@gmx.de] 
Sent: Friday, January 03, 2003 3:23 PM
To: linux-kernel@vger.kernel.org
Subject: Kernel bug in agpgart module!

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

	if ((pg_start + mem->page_count) > num_entries) {  //<--- This check
fails
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
