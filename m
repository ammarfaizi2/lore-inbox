Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265726AbUEZO7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUEZO7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 10:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbUEZO7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 10:59:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:55714 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265726AbUEZO7q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 10:59:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [ANNOUNCE] DKMS now with architecture awareness
Date: Wed, 26 May 2004 09:55:01 -0500
Message-ID: <FD3BA83843210C4BA9E414B0C56A5E5C47F042@ausx2kmpc104.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] DKMS now with architecture awareness
Thread-Index: AcRDMWvrVBDGJLoTT8qMAPgsvV5xQg==
From: <Gary_Lerhaupt@Dell.com>
To: <dkms-devel@lists.us.dell.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 May 2004 14:55:02.0054 (UTC) FILETIME=[6C2CA460:01C44331]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DKMS is a project Dell is maintaining to solve the necessity for a kernel
module update model.  You can read more about why this is needed and a good
thing here: http://www.dell.com/downloads/global/power/1q04-ler.pdf or 
here: http://www.linuxjournal.com/article.php?sid=6896 (somewhat out of date).

In any case, previously DKMS was unable to handle the management of kernel
modules across architectures.  Meaning, it was unable to handle built kernel
modules for the same kernel name but different architecture (note that the
current /lib/modules naming paradigm still cannot handle this either).  To
resolve this, I have introduced a testing version of DKMS which adds 
multi-arch support.  Rather than storing your built modules in 
/var/dkms/$module/$modulever/$kernel/, it now stores it in 
/var/dkms/$module/$modulever/$kernel/$arch/.  The testing versions will be 
1.9x as we flesh out this addition.  Once ready, we'll move DKMS to 2.0.  
1.9x should automatically update your old DKMS tree to the new format
assuming that your built modules are for arch `uname -m`. The latest stable
version of DKMS is 1.10.

Latest: http://linux.dell.com/dkms/testing/permalink/dkms-1.90.46.tar.gz
Changeblog: http://linux.dell.com/blog/2004/05/26/#0916
Project: http://linux.dell.com/dkms/dkms.html

Thanks.

Gary Lerhaupt
Dell Linux Development
http://linux.dell.com
