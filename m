Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136716AbREAUfn>; Tue, 1 May 2001 16:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136713AbREAUfX>; Tue, 1 May 2001 16:35:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45835 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132567AbREAUfN>; Tue, 1 May 2001 16:35:13 -0400
Subject: Re: Linux Cluster using shared scsi
To: Eric.Ayers@intec-telecom-systems.com
Date: Tue, 1 May 2001 21:38:26 +0100 (BST)
Cc: dledford@redhat.com (Doug Ledford),
        James.Bottomley@steeleye.com (James Bottomley),
        Chris.Roets@compaq.com (Roets Chris), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <15086.60620.745722.345084@gargle.gargle.HOWL> from "Eric Z. Ayers" at May 01, 2001 01:05:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uguj-0002KC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this package also tell the kernel to "re-establish" a
> reservation for all devices after a bus reset, or at least inform a
> user level program?  Finding out when there has been a bus reset has
> been a stumbling block for me.

You cannot rely on a bus reset. Imagine hot swap disks on an FC fabric. I 
suspect the controller itself needs to call back for problem events

