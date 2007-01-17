Return-Path: <linux-kernel-owner+w=401wt.eu-S932117AbXAQJ3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbXAQJ3Z (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXAQJ3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:29:24 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:48947 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbXAQJ3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:29:24 -0500
X-Greylist: delayed 1455 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 04:29:23 EST
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: NTFS deadlock on 2.6.18.6
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20070109205249.GA3802@procyon.home>
References: <20070109205249.GA3802@procyon.home>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Wed, 17 Jan 2007 09:04:34 +0000
Message-Id: <1169024674.10503.12.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2007-01-09 at 23:52 +0300, Sergey Vlasov wrote:
[snip excellent analysis]
> Seems that grabbing i_mutex in ntfs_put_inode() is not safe after all
> (and lockdep cannot see this deadlock possibility, because one of
> waits is __wait_on_freeing_inode - not a standard locking primitive).

Inded.  Thanks a lot for the report and detailed analysis!  Much
appreciated.

I have been meaning to do the needed changes anyway so the new OSX and
Linux drivers are more alike but had not gotten round to it yet...  Now
that I know it actually causes a deadlock I will bite the bullet and do
the changes now.

ps. Aplogies for delayed response but I was on holiday without
computers/internet access...

Best regards,

	Anton

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/

