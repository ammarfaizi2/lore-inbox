Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUH2RWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUH2RWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268223AbUH2RWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:22:20 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:35811 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S268216AbUH2RWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:22:09 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16690.4288.260815.847844@thebsh.namesys.com>
Date: Sun, 29 Aug 2004 21:22:08 +0400
To: Spam <spam@tnonline.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, <christophe@saout.de>,
       <vda@port.imtp.ilyichevsk.odessa.ua>, <christer@weinigel.se>,
       Andrew Morton <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <10558145.20040829185217@tnonline.net>
References: <1732169380.20040827224404@tnonline.net>
	<200408291521.i7TFLsQk028363@localhost.localdomain>
	<10558145.20040829185217@tnonline.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam writes:
 > 
 > > Spam <spam@tnonline.net> said:
 > >> Horst von Brand <vonbrand@inf.utfsm.cl> said:

[...]

 > 
 > > Show benefits, show there are no downsides. Show that the same can't
 > > possibly be done in userland. Then I'll consider buying it.
 > 
 >   I am not saying it couldn't be done in userland. Most things can.
 > 
 >   The  problem with userland is that it doesn't provide generic access
 >   across  most  applications. For example GnomeVFS is limited to Gnome
 >   applications  only.  The  same  for  KDE.  to  be able to coordinate
 >   application developer on anything is just almost impossible.

Hmm... drag-and-drop also doesn't work constently over all
applications. Let's put it into kernel.

Seriously, kernel prformance is critical to the system, and to achieve
high performance all kernel code runs in single address space (actually,
in portion of address spaces of user processes shared by all
processes). All shared system state is located there. This means that
bug in a kernel affects whole system. This means that kernel should be
kept as simple as possible (and a bit more simple).

This is why only things that cannot be done efficiently in the user
level are put into kernel. And political agendas of various camps of
user-level developers change nothing here.

 > 
 >   Still.  Why do you oppose plugins, streams and meta files? The could
 >   be   valuable   and  easy  to use tools for many purposes. One could
 >   be  would be advanced ACLs defined as a meta-file using XML format.

POSIX has standard ACL API in C (well, "eternal draft" only), one can
use it to extract ACLs from kernel and convert it to any format to one's
heart content. Advantage of this is that when XML goes out of fashion (I
hope this wouldn't yet happen when you will read this message), kernel
API will remain intact.

 >   

Nikita.
