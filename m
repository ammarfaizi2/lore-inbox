Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130003AbQLWHuz>; Sat, 23 Dec 2000 02:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbQLWHup>; Sat, 23 Dec 2000 02:50:45 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:41990
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130003AbQLWHud>; Sat, 23 Dec 2000 02:50:33 -0500
Date: Sat, 23 Dec 2000 20:20:03 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Damacus Porteng <kernel@bastion.yi.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Arg.  File > 2GB removal
Message-ID: <20001223202003.A9216@metastasis.f00f.org>
In-Reply-To: <20001223021615.A8201@bastion.sprileet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001223021615.A8201@bastion.sprileet.net>; from kernel@bastion.yi.org on Sat, Dec 23, 2000 at 02:16:15AM -0600
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you don't mention which kernel you are using, but for some time now
ext2fs has been able to handle large files (>2GB) -- and I suspect dd
created such a beast for you

rm probably stat'd the file beforing removing it -- and failed,
because it's either old or uses and old library (which isn't LFS
aware)



  --cw


On Sat, Dec 23, 2000 at 02:16:15AM -0600, Damacus Porteng wrote:
    For grins, I did `dd if=/dev/zero of=testfile bs=1024 count=4000000` 
    
    Obviously, with the limits of ext2, this isn't allowed, however, dd continued
    marrily on its way, tho it spouted an error...
    
    I cancelled the dd and went to remove the file, though the following occured:
    root@obfuscated:/home/ftp# rm testfile
    rm: cannot remove `testfile': Value too large for defined data type     
    
    'ls' complains about the same.  I ran e2fsck -f /dev/hde6 (the partition of
    /home) and it didn't 'find' the problem.
    
    How do I remove this file and reclaim the HDD space?
    
    Thanks,
    
    D.
    -
    To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
    the body of a message to majordomo@vger.kernel.org
    Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
