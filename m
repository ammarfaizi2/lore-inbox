Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284652AbRLEUVT>; Wed, 5 Dec 2001 15:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284645AbRLEUTx>; Wed, 5 Dec 2001 15:19:53 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:56335 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S284646AbRLEUTl>;
	Wed, 5 Dec 2001 15:19:41 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Wed, 5 Dec 2001 21:19:28 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Removing an executable while it runs
CC: Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <B26DFE70816@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Dec 01 at 11:32, Mike Fedyk wrote:
> > No. Some will refuse to unlink running app (or another opened file).
> > Some will unlink it immediately, and app then dies when it needs
> > page-in something. Some works as POSIX mandates.
> > 
> 
> POSIX behaviour would be in ext[23], reiserfs, xfs, (and probably ffs,
> ntfs).  Can someone verify which FSes have what behaviour?
> 
> I'd guess that vfat (fat16/28--err, 32), nfs, and hfs would delete
> immediately.

ncpfs (and afaik smbfs) will refuse to delete file. For local filesystems
there is no excuse to not support POSIX semantic on unlink if they do not
store data together with filename.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
