Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWAFOoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWAFOoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWAFOoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:44:19 -0500
Received: from [81.2.110.250] ([81.2.110.250]:59546 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932435AbWAFOoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:44:19 -0500
Subject: RE: RAID controller safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F02026FB0@otce2k03.adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F02026FB0@otce2k03.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Jan 2006 14:46:47 +0000
Message-Id: <1136558807.30498.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-06 at 09:33 -0500, Salyzyn, Mark wrote:
> The dpt_i2o driver (which is a scsi driver) accepts the
> SYNCHRONIZE_CACHE scsi command and passes it off to the firmware. The
> firmware respects this and flushes all the outstanding (cached)
> commands. This is true in all (kernel.org or Adaptec latest) versions.

In which case it should be fine and correct with the generic i2o_scsi as
well as that will pass through SCSI command requests directly. i2o_block
doesn't know about converting any incoming cache flush to an i2o command
block so might not.

Alan

