Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135700AbRDXQJy>; Tue, 24 Apr 2001 12:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135697AbRDXQJo>; Tue, 24 Apr 2001 12:09:44 -0400
Received: from [194.46.8.33] ([194.46.8.33]:57606 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S135695AbRDXQJf>;
	Tue, 24 Apr 2001 12:09:35 -0400
Date: Tue, 24 Apr 2001 17:08:12 +0100
From: Dale Amon <amon@vnl.com>
To: "David L. Nicol" <david@kasey.umkc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Idea: Encryption plugin architecture for file-systems
Message-ID: <20010424170812.B28404@vnl.com>
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com> <01042121404701.08246@antares> <20010423211237.I26083@vnl.com> <3AE4EAEA.26F37BEB@kasey.umkc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AE4EAEA.26F37BEB@kasey.umkc.edu>; from david@kasey.umkc.edu on Mon, Apr 23, 2001 at 09:54:34PM -0500
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 09:54:34PM -0500, David L. Nicol wrote:
> why not port one of the twenty or thirty preexisting tools
> that let you mount a filesystem from an encrypted file instead
> of making a generic layer?  That way you could have inter-os 
> portability.  The steganographic ones make really impressive
> claims.  

I'm doing an 18GB raid file system. The standard loopback is
working fine. What I am unsure of is the bobustness against lost
blocks when running "on the metal" vs interposing another file
system layer.

I suspect the answer is that each block is individually encrypted,
so that the worst case data loss is the same; that an ext2 on
top of an encrypted partition would be no worse off than the 
same file system without the interposed layer. Both would find
a bad block and do their best.

But my knowledge of how the loopbacks are structured is not
good enough for me to say this with confidence. That's why 
I'm asking here: in hopes that someone who really does know
can say something about the worst case data loses.

-- 
------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------
