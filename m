Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRIDTHz>; Tue, 4 Sep 2001 15:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRIDTHe>; Tue, 4 Sep 2001 15:07:34 -0400
Received: from [208.48.139.185] ([208.48.139.185]:55706 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S267043AbRIDTHY>; Tue, 4 Sep 2001 15:07:24 -0400
Date: Tue, 4 Sep 2001 12:07:37 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS to Irix server broken again in 2.4.9
Message-ID: <20010904120737.A17459@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15253.1002.189305.674221@barley.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15253.1002.189305.674221@barley.abo.fi>; from mhuhtala@abo.fi on Tue, Sep 04, 2001 at 07:40:10PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 07:40:10PM +0300, Mikko Huhtala wrote:
> 
> Don't know if this is well-known already. The 2.4.9 kernel NFS client
> does not see all files/directories mounted from an Irix 6.5 NFS server
> (the 32/64-bit cookie problem). Changing NFS versions from 3 to 2 does
> not help. 2.4.8 client works for me, but the problem is apparently
> back in 2.4.9. I am running 2.4.9 with MOSIX 1.3.0 patches, but I do
> not think that those are the cause of the problem.

As far as I know, this has been broken for quite a while.  You need to apply
the patches at http://www.fys.uio.no/~trondmy/src/ (specifically the seekdir
patch), as well as supply the 32bitclients option to the IRIX NFS server in
2.4.9.  Previous 2.4.X kernels didn't require the 32bitclients option on the
IRIX server for some reason.

After doing both of these things, everything appears to work properly over
here in my testing.

-Dave
