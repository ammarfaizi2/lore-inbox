Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313557AbSD3Nkt>; Tue, 30 Apr 2002 09:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSD3Nks>; Tue, 30 Apr 2002 09:40:48 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:20234 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313557AbSD3Nks>;
	Tue, 30 Apr 2002 09:40:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback 
In-Reply-To: Your message of "Tue, 30 Apr 2002 23:15:23 +1000."
             <20020430131523.GA22705@higherplane.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Apr 2002 23:40:38 +1000
Message-ID: <9595.1020174038@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002 23:15:23 +1000, 
john slee <indigoid@higherplane.net> wrote:
>probably because there is software out there relying on them being
>numbers and being able to do 'if(inum_a == inum_b) { same_file(); }'
>as appropriate.  i can't think of a use for such a construct other than
>preserving hardlinks in archives (does tar do this?) but i'm sure there
>are others

Any program that tries to preserve or detect hard links.  cp, mv (files
a and b are the same file).  tar, cpio, rsync -H, du, etc.

The assumption that inode numbers are unique within a mount point is
one of the reasons that NFS export does not cross mount points by
default.  man exports, look for 'nohide'.

