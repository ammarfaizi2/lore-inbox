Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRHBAkg>; Wed, 1 Aug 2001 20:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268331AbRHBAk0>; Wed, 1 Aug 2001 20:40:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268243AbRHBAkO>; Wed, 1 Aug 2001 20:40:14 -0400
Subject: Re: 3ware Escalade problems
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Thu, 2 Aug 2001 01:40:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ransom@cfa.harvard.edu (Scott Ransom),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010801184032.A22548@vger.timpanogas.org> from "Jeff V. Merkey" at Aug 01, 2001 06:40:32 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15S6Xn-00088F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try putting four adapters into a system all at once with 32 drives, and 
> you will see all sorts of bugs.  I do not see problems with a single board,
> other than gendisk reporting junk.  If it's the scsi layer, then the driver 
> must not be calling the sd driver.  I will attempt to get on the phone with
> Adam, and get these issues resolved.

The scsi disk layer does the entire gendisk stuff itself. Its actually
very hard for a scsi driver to screw that up - the scsi driver has no
real concept of a 'disk'. sd talks to a disk and the scsi driver just gets
messages posted around.

Alan

