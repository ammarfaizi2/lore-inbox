Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbTIKVBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTIKVBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:01:46 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:49396 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261518AbTIKVBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:01:45 -0400
Date: Thu, 11 Sep 2003 15:00:17 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Kyle Rose <krose+linux-kernel@krose.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
Message-ID: <20030911150017.T18851@schatzie.adilger.int>
Mail-Followup-To: Kyle Rose <krose+linux-kernel@krose.org>,
	linux-kernel@vger.kernel.org
References: <87r82noyr9.fsf@nausicaa.krose.org> <20030911144732.S18851@schatzie.adilger.int> <87n0dboxhg.fsf@nausicaa.krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87n0dboxhg.fsf@nausicaa.krose.org>; from krose+linux-kernel@krose.org on Thu, Sep 11, 2003 at 04:56:27PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 11, 2003  16:56 -0400, Kyle Rose wrote:
> > I would guess that mkisofs isn't opening the file with O_LARGEFILE.
> > It probably only expected to write 600MB output files.  Purely a
> > guess though.
> 
> Thanks for the suggestion, but it is, in fact, opening with
> O_LARGEFILE:
> 
> open("/mnt/angband/krose/tmp/862839.img", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3

True, and O_LARGEFILE would have bit you at 2GB and not 4GB...  If you are
doing output redirected from the shell, then it can't be a seek issue
either.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

