Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312317AbSCZT04>; Tue, 26 Mar 2002 14:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312450AbSCZT0q>; Tue, 26 Mar 2002 14:26:46 -0500
Received: from 209-VALL-X7.libre.retevision.es ([62.83.213.209]:34568 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S312317AbSCZT0l>; Tue, 26 Mar 2002 14:26:41 -0500
Date: Tue, 26 Mar 2002 20:26:16 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Thomas Habets <thomas@habets.pp.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mtime changeable on immutable files (a bug, isn't it?)
Message-ID: <20020326202616.C2539@ragnar-hojland.com>
In-Reply-To: <02032519245700.00785@marvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 07:24:57PM +0100, Thomas Habets wrote:
> You can touch(1) an immutable file, which changes its mtime. Since you can't
> change the permission bits of the inode, you shouldn't be able to change the
> mtime, correct?

You could reason that since the immutable flag is set at i_mode, and i_mode
stores file modes, it should be legal to change the inode (mtime) as long as
you do not change the contents of the file.

Or at least that that would be the intention of chattr, if you re-read the
page:

       A  file with the i' attribute cannot be modified: it can<AD>
       not be deleted or renamed, no link can be created to  this
       file  and  no  data  can  be written to the file. Only the
       superuser can set or clear this attribute.

Even if you obviate the inode/file difference, by changing mtime you aren't
either deleting, renaming, linking or writing data to the file, so you are
consistent to the pubished documentation.
-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."      [15 pend. Mar 10]
