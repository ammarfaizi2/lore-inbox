Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293713AbSCFRTW>; Wed, 6 Mar 2002 12:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293712AbSCFRTM>; Wed, 6 Mar 2002 12:19:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49426 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293704AbSCFRS7>; Wed, 6 Mar 2002 12:18:59 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Wed, 6 Mar 2002 17:33:11 +0000 (GMT)
Cc: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard),
        linux-kernel@vger.kernel.org
In-Reply-To: <200203061708.MAA02691@ccure.karaya.com> from "Jeff Dike" at Mar 06, 2002 12:08:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ifHr-0007XT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that this doesn't help when the UMLs are under a smaller limit than 
> RAM + .5 * swap or whatever as happens when they are mmapping from tmpfs.
> That's the situation that I'm concerned about.

Making tmpfs enforce the policy in those modes both checking the global
overcommit and also enforcing a "must be able to fill in the pages between
start and end of file" for the tmpfs file size itself is not hard from
inspection. If its needed I can add that next update to the address
accounting.
