Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292665AbSBZSbb>; Tue, 26 Feb 2002 13:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292657AbSBZS3x>; Tue, 26 Feb 2002 13:29:53 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:9481 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S292658AbSBZS3b>; Tue, 26 Feb 2002 13:29:31 -0500
Date: Tue, 26 Feb 2002 19:29:29 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226192929.B23093@devcon.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com>; from wrose@loislaw.com on Tue, Feb 26, 2002 at 11:48:49AM -0600
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 11:48:49AM -0600, Rose, Billy wrote:
> 
> My company can tolerate 0% loss of data (which is why I raised this issue).

There are a zillion ways to accidentally destroy a file.

Ever typed ">" instead of ">>"? Ever cp'ed to the wrong destination?
Ever edited the wrong file with vi and recognized it just after the
":wq"? 

All of this just truncates the old file without unlink()ing it first.
So simple undeletion can /never/ provide by any means any protection
against accidental data loss.

Backup can, but not for the most recent data. Try shortening the
timespan between two backups (for example using LVM snapshots), that
will give you much more protection than pushing the dead horse called
"undeletion".

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
