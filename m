Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbREQHsh>; Thu, 17 May 2001 03:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbREQHsS>; Thu, 17 May 2001 03:48:18 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:42602 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S261330AbREQHsO>; Thu, 17 May 2001 03:48:14 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: Pavel Machek <pavel@suse.cz>, Jes Sorensen <jes@sunsite.dk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up 
In-Reply-To: Your message of "Thu, 17 May 2001 03:26:36 -0400."
             <20010517032636.A1109@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 May 2001 17:47:41 +1000
Message-ID: <28870.990085661@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001 03:26:36 -0400, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Pavel Machek <pavel@suse.cz>:
>> And If I want scsi-on-atapi emulation but not vme147_scsi?
>
>Help me understand this case, please.  What is scsi-on-atapi?
>Is SCSI on when you enable it?  And is it a realistic case for an SBC?

SCSI emulation over IDE, CONFIG_BLK_DEV_IDESCSI.  You have the SCSI mid
layer code but no SCSI hardware drivers.  It is a realistic case for an
embedded CD-RW appliance.

BTW, there is a bug in the current setting of CONFIG_BLK_DEV_IDESCSI.
Starting with CONFIG_SCSI unset, you can set BLK_DEV_IDESCSI to y and
later set SCSI to n and get a mess, even with make oldconfig.  I am
discussing the fix with Andre Hendrick, expect BLK_DEV_IDESCSI to move
to the SCSI menu.

