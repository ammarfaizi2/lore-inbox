Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbSJQU0N>; Thu, 17 Oct 2002 16:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSJQUZt>; Thu, 17 Oct 2002 16:25:49 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:2948 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262034AbSJQUYM>; Thu, 17 Oct 2002 16:24:12 -0400
Message-ID: <3DA24B4A0064C333@mel-rta8.wanadoo.fr> (added by
	    postmaster@wanadoo.fr)
From: christophe varoqui <christophe.varoqui@free.fr>
Subject: block allocators and LVMs
To: linux-kernel@vger.kernel.org
Date: Thu, 17 Oct 2002 22:30:05 +0200
Organization: devoteam
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

reading the recent threads about FS block allocator algorithms and about 
possible integration of a new volume management framework, I wondered if 
the role of intelligent block allocators and/or online FS defragmentation  
could be replaced by a block remapper in the LVM subsystem.

On one hand, online defrag seems hard to achieve (Tru64 advfs still can't 
get it right after 4 years) and intelligently allocating blocks can be 
costly (not to say it could be useless on a heavily fragmented logical 
volume) ... on the other hand, the pvmove envisionned by M. Thornber seems 
quite able to handle the extend remapping.

The block device layer is pretty well positioned to know about disk head 
seeks and could do IO accounting per extend. These information seems 
sufficient to efficiently order extends.

Am I completely out of my mind ?
Evidently, I would be very proud if not but I can handle responses like 
"crap. just stop thinking man"

.
cvaroqui
