Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265086AbRFZSCg>; Tue, 26 Jun 2001 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbRFZSC1>; Tue, 26 Jun 2001 14:02:27 -0400
Received: from gateway.sequent.com ([192.148.1.10]:6876 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S265074AbRFZSCN>; Tue, 26 Jun 2001 14:02:13 -0400
Date: Tue, 26 Jun 2001 11:00:40 -0700
From: Patrick Mansfield <patman@sequent.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: multi-path IO in SCSI mid-layer
Message-ID: <20010626110040.A28555@eng2.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

I'm interested in multi-path IO in the linux scsi mid-layer.

Are there developers working on changes to the scsi layers/interfaces?
I've seen references about such work, but no details.

Anyone else interested in or working on multi-path IO in the mid-layer?

I've looked at the code as to what changes might be required, and did
a simple prototype to issue IO requests using multiple paths for one device -
configuring one device in with multiple paths using SCSI INQUIRY page 0x83,
and selecting a path (just round-robin) at scsi_submit_cmd() time.

But, a decent multi-path IO implementation requires significant changes
to the current linux scsi interfaces/structures - especially where no
functional interfaces exist, such as the direct references to Scsi_Device
host, and Scsi_Host host_queue.

-- 
Patrick Mansfield
patman@sequent.com
patman@us.ibm.com
