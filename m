Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311804AbSCTQoe>; Wed, 20 Mar 2002 11:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311824AbSCTQoY>; Wed, 20 Mar 2002 11:44:24 -0500
Received: from pat.uio.no ([129.240.130.16]:8657 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S311804AbSCTQoE>;
	Wed, 20 Mar 2002 11:44:04 -0500
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: eddantes@wanadoo.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.7] undefined reference to `sys_nfsservctl'
In-Reply-To: <Pine.SOL.3.96.1020320162809.19016A-100000@draco.cus.cam.ac.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Mar 2002 17:43:55 +0100
Message-ID: <shsd6xztcj8.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Anton Altaparmakov <aia21@cus.cam.ac.uk> writes:

     > Al Viro has a patch for this on his ftp site but you can get
     > over the compile problemy by simply enabling both nfs and nfs
     > server in the kernel configuration, no patch needed in that
     > case... I.e. you want to set these:

    >> # CONFIG_NFS_FS is not set CONFIG_NFS_V3 is not set CONFIG_NFSD
    >> # is not set CONFIG_NFSD_V3 is not set

No point in compile in the NFS client unless you really need it.
sys_nfsservctl is a knfsd-only thing, so you shouldn't need either
CONFIG_NFS_FS or CONFIG_NFS_V3 if you only want get around the bug.

Cheers,
  Trond
