Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267165AbSKMK7M>; Wed, 13 Nov 2002 05:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbSKMK7M>; Wed, 13 Nov 2002 05:59:12 -0500
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:14029 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S267165AbSKMK7L>; Wed, 13 Nov 2002 05:59:11 -0500
Date: Wed, 13 Nov 2002 12:06:01 +0100
From: Brice Goglin <bgoglin@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: Duplicated code in grab_cache_page, __grab_cache_page, ...
Message-ID: <20021113110601.GE11564@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a large part of code which looks duplicated
in __grab_cache_page, grab_cache_page (and some parts of
do_generic_file_read (in the "no_cached_page:" section))
in mm/filemap.c.

I do not see the real difference between grab_cache_page
and __grab_cache_page (except the additional
"struct page *cached_page" argument).
The fact that the first one is exported while the second
one is static looks strange to me.
Why not exporting both of them if the are really different ?
Or why not merging them into a general purpose grab_cache_page ?

I've seen some small changes during 2.5 developpement
(grab_cache_page moved to pagemap.h, __grab_cache_page
got a new argument).
I'd like to know whether you planned to clean this point
in future 2.5 revisions ?

Regards

--
Brice Goglin,
Laboratoire de l'Informatique du Parallelisme
ENS Lyon - 46 allée d'Italie
69007 LYON - France
