Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282850AbRLWBDY>; Sat, 22 Dec 2001 20:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283002AbRLWBDO>; Sat, 22 Dec 2001 20:03:14 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:59140 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S282850AbRLWBDB>; Sat, 22 Dec 2001 20:03:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: James A Sutherland <james@sutherland.net>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        "'Alexander Viro'" <viro@math.psu.edu>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 20:02:34 -0500
X-Mailer: KMail [version 1.3.2]
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com> <T57eadc70a6ac1785e2316@pcow024o.blueyonder.co.uk>
In-Reply-To: <T57eadc70a6ac1785e2316@pcow024o.blueyonder.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Hx23-000220-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 December 2001 4:34, James A Sutherland wrote:

> Initramfs will do this, it seems. Alternatively, you might have to copy
> some files into a tarball - oh, the stress! Oh, wait - you just compiled
> 100+Mb of C source to make that kernel and the modules. Somehow, making a
> tarball out of the modules doesn't seem too stressful to me.

Do it for 15 production systems, each with varying hardware.
Now do it again for kernel revision 2. Now again for rev 3. Now
again for rev 1 of 2.4.17...

OR

List the names of the modules for boot ONCE in the systems 'grub.conf'
file, and just create a 'current' symlink each time you install
a new kernel and modules. A simple user land util can parge depmod to
give you to right order...no bloat needed.

FYI I only ned create a 'vmlinuz' for new kernel install as it is.
If I could do the same for modules, I wouldn't have a 1.3MB
'catch all' bzImage.

> OK, make the conf file a shell script which copies the modules into a
> tarball or initrd image.

Oh that's nice, clean, and standardized! Again do it for 15 machines...

Many of you people spouting about 'kernel design' really need to get
a clue about putting these things into real world practise, across
mutiple machines, that must stay running...



-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
