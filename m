Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWIPHtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWIPHtB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 03:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWIPHtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 03:49:01 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:161 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751207AbWIPHtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 03:49:00 -0400
Date: Sat, 16 Sep 2006 03:48:58 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: [PATCH 0/11] LTTng-core 0.5.111 : Relay+DebugFS
Message-ID: <20060916074858.GA29360@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 03:45:05 up 24 days,  4:53,  3 users,  load average: 0.05, 0.09, 0.09
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I fixed the technical issues pointed earlier (one code path was not locked 
correctly while the other was more restrictive than necessary about what
modules could be loaded/unloaded when tracing is active) and moved to Relay and
DebugFS. I also found a corner case where DebugFS keeps a stalled dentry if a
process in using the directory when deleted : I think this fix should be
considered for merging.


Mathieu



OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
