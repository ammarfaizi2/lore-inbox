Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280809AbRKYKdk>; Sun, 25 Nov 2001 05:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280812AbRKYKda>; Sun, 25 Nov 2001 05:33:30 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19954
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280809AbRKYKdV>; Sun, 25 Nov 2001 05:33:21 -0500
Date: Sun, 25 Nov 2001 02:33:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Michael Zimmermann <zim@vegaa.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andreas Dilger <adilger@turbolabs.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011125023314.B30336@mikef-linux.matchmail.com>
Mail-Followup-To: Michael Zimmermann <zim@vegaa.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Dilger <adilger@turbolabs.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E167Fuw-00001K-00@DervishD> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011123174120.Q1308@lynx.no> <9tmr83$jo2$1@cesium.transmeta.com> <20011123212557.U1308@lynx.no> <3BFF2AAE.7000000@zytor.com> <3BFF8692.7060900@vegaa.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BFF8692.7060900@vegaa.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 12:37:54PM +0100, Michael Zimmermann wrote:
> Excuse me, if I jump in with almost zero linux-kernel-knowledge,
> and take my words as a third-party comment.
> 
> May be, I've not seen enough in 35 years of system programming
> (including designing and writing journal-systems my own),
> but I've never seen a journal beeing part of the data-space to be
> journalled. It is simply an ugly thing in the file space. It either belongs
> into /proc/fs/ext3 (or the like) or is not to be shown at all. Except
> there was a valid neccessity to have it in the normal file space.
> 

You do not understand the reasons behind the thread.

.journal files are only created when an ext2 FS is converted to ext3 *while*
it is mounted.  In this case tune2fs just creates a file (.journal) and
modifies a couple fields in the super block.

The newest e2fsck (1.25) will hide the file for you, just like it would be
if the conversion was done on an unmounted FS.

MF
