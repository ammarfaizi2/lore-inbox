Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbVKIWhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbVKIWhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbVKIWhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:37:48 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:64203 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751536AbVKIWhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:37:47 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.31257.240080.519064@tut.ibm.com>
Date: Wed, 9 Nov 2005 16:37:13 -0600
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, gregkh@suse.de
Subject: Re: [PATCH 4/4] relayfs: Documentation for exported relay fileops
In-Reply-To: <20051109140336.2d584067.akpm@osdl.org>
References: <17266.28537.722390.913812@tut.ibm.com>
	<20051109140336.2d584067.akpm@osdl.org>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Tom Zanussi <zanussi@us.ibm.com> wrote:
 > >
 > > +By default of course, relay_open() creates relay files in the relayfs
 > >  +filesystem.  Because relay_file_operations is exported, however, it's
 > >  +also possible to create and use relay files in other pseudo-filesytems
 > >  +such as debugfs.
 > 
 > Why would anyone wish to place relayfs files within other
filesystems?

The reason they're exported is that when relayfs was being considered
for inclusion, GregKH requested that the relay file operations be
exported, which I did but didn't actually try to use them there until
now.  It turns out that the current patch's changes are needed in
order to be able to do that.  The reason behind being able to do this
I assume is so that developers can use relay files do ad hoc tracing
inside debugfs rather than have part of their application in debugfs
and another part in relayfs.  Maybe Greg can chime in as to whether he
thinks it's still useful, or maybe I should just remove the export?

Tom



