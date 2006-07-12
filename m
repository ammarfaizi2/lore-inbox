Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWGLG1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWGLG1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGLG1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:27:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:2511 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932451AbWGLG1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:27:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JGN85NfpRixi3nrgFbgctL8kOzDXjWwwQ8RDXFEb1gENyNSgV0JiUpgod830/jKBP7snWaQpQAzKyRfo6gSctotCrEWQSFm1WxX6ZwhfywFej/iluXVLtQ2DxywM48gWuo8VR0j13UJW35JFtNvP/Fkn6eTTw+ucAW/M+tFECbE=
Message-ID: <84144f020607112327y48d9cccueb4c5e3904d6981@mail.gmail.com>
Date: Wed, 12 Jul 2006 09:27:46 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Theodore Tso" <tytso@mit.edu>, "Jon Smirl" <jonsmirl@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
In-Reply-To: <20060710233944.GB30332@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <20060710233944.GB30332@thunk.org>
X-Google-Sender-Auth: ccb5dabe223e9da7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/11/06, Theodore Tso <tytso@mit.edu> wrote:
> When I wrote the do_SAK code about 12-13 years ago, tty->tty_files
> didn't exist.  It should be safe to do this, but I'll echo Alan's
> comment.  We really ought to implement revoke(2) at the VFS layer, and
> then utilize to implement SAK and vhangup() functionality.

How is this supposed to work? What's stopping a process from
re-opening the file after revoke(2) has been called? Or am I missing
something here?

                                     Pekka
